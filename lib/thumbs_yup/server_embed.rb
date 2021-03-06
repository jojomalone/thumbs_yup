module ThumbsYup
  module ServerEmbed
    class << self
      require 'net/http'
      require 'json'
      require_relative 'template_renderer'
      require_relative 'error_renderer'

      def render_public_reviews(page: nil)
        check_user_identifer!

        review_data = json_review_data(page: page)
        reviews = review_data["reviews"]
        metadata = review_data["metadata"]

        html = if review_data["message"]
          ThumbsYup::ErrorRenderer::render_page(
            message: review_data["message"]
          )
        else
          ThumbsYup::TemplateRenderer::render_page(
            settings: settings,
            pagination: pagination(metadata),
            reviews: reviews
          )
        end

        html.respond_to?(:html_safe) ? html.html_safe : html
      end

      private

      def check_user_identifer!
        if ThumbsYup.configuration.user_identifier.nil?
          raise <<-EOS
            Create your user_identifier in: config/initializers/thumbs_yup_init.rb
            ThumbsYup.configure do |config|
              config.user_identifier = "your-website-identifier"
            end
          EOS
        end
      end

      def json_review_data(page:)
        url = ThumbsYup.configuration.thumbs_yup_url + '/site/' + ThumbsYup.configuration.user_identifier

        uri = URI.parse(url)
        params = { :page => page }
        uri.query = URI.encode_www_form(params)

        request = Net::HTTP::Get.new(uri.request_uri)
        request["User-Agent"] = "My User Agent"
        request["Accept"] = "application/json"

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        response = http.request(request) rescue nil

        if response.present? && !response.body.blank?
          JSON.parse(response.body)
        else
          { "message" => "Service unavailable" }
        end
      end

      def settings
        {
          review_style: ThumbsYup.configuration.review_style,
          review_color: ThumbsYup.configuration.review_color,
          review_background: ThumbsYup.configuration.review_background,
          review_size: ThumbsYup.configuration.review_size,
          thumbs_yup_url: ThumbsYup.configuration.thumbs_yup_url
        }
      end

      def pagination(metadata)
        return nil if metadata.nil?
        {
          current_page: metadata["current_page"],
          total_count: metadata["total_count"],
          per_page: metadata["per_page"]
        }
      end
    end
  end
end

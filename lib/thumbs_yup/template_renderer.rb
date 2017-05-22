require 'erb'
require 'ostruct'
require_relative 'review_decorator'

module ThumbsYup
  class TemplateRenderer < OpenStruct
    class << self
      def render_page(vars)
        vars[:reviews] = reviews_html(vars[:reviews])

        TemplateRenderer.new(vars).render(page_template)
      end

      private

      def reviews_html(reviews)
        reviews.reduce("") do |acc, review|
          acc << render_review(review)
        end
      end

      def render_review(vars)
        vars = ThumbsYup::ReviewDecorator.new(vars).review
        TemplateRenderer.new(vars).render(review_template)
      end

      def review_template
        style = ThumbsYup.configuration.review_style
        background = ThumbsYup.configuration.review_background
        template_file = style + "_" + background + ".erb"
        File.read(
          File.join(File.dirname(__FILE__), 'templates', template_file)
        )
      end

      def page_template
        File.read(
          File.join(File.dirname(__FILE__), 'reviews.erb')
        )
      end
    end

    def render(template)
      ERB.new(template).result(binding)
    end
  end
end

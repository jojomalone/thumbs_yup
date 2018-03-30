require 'erb'
require 'ostruct'

module ThumbsYup
  class ErrorRenderer < OpenStruct
    class << self
      def render_page(vars)
        vars = map_message(vars)

        ErrorRenderer.new(vars).render(page_template)
      end

      private

      def map_message(vars)
        message = case vars[:message]
        when "Record not found"
          "Error: Please check your configuration and ensure that you have a ThumbsYup account."
        else
          "Error:  There was an error retrieving you reviews."
        end

        vars[:message] = message

        vars
      end

      def page_template
        File.read(
          File.join(File.dirname(__FILE__), 'error.erb')
        )
      end
    end

    def render(template)
      ERB.new(template).result(binding)
    end
  end
end

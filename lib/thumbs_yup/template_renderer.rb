require 'erb'
require 'ostruct'

class TemplateRenderer < OpenStruct
  def self.render_review(vars)
    style = ThumbsYup.configuration.review_style
    background = ThumbsYup.configuration.review_background
    template_file = style + "_" + background + ".erb"

    template = File.read(
      File.join(File.dirname(__FILE__), 'templates', template_file)
    )
    TemplateRenderer.new(vars).render(template)
  end

  def self.render_page(vars)
    template = File.read(
      File.join(File.dirname(__FILE__), 'reviews.erb')
    )
    TemplateRenderer.new(vars).render(template)
  end

  def render(template)
    ERB.new(template).result(binding)
  end
end

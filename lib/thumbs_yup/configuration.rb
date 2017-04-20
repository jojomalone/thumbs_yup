module ThumbsYup
  class Configuration
    attr_accessor :user_identifier
    attr_accessor :review_style
    attr_accessor :review_color
    attr_accessor :review_background
    attr_accessor :review_size
    attr_accessor :thumbs_yup_url

    def initialize
      @review_style = 'bubble'
      @review_color = 'blue'
      @review_background = 'hollow'
      @review_size = 'med'
      @thumbs_yup_url = 'http://www.thumbsyup.com'
    end
  end
end

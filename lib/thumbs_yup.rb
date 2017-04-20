require "thumbs_yup/version"
require 'thumbs_yup/configuration'
require 'thumbs_yup/server_embed'

module ThumbsYup
  class << self
    def configure(&block)
      yield(configuration)
      configuration
    end

    def configuration
      @_configuration ||= Configuration.new
    end
  end
end

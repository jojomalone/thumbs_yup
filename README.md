# ThumbsYup

Tools for integrating with the thumbsyup.com web services.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thumbs_yup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thumbs-yup

## Usage

Create an initializer: `config/initializers/thumbs_yup_init.rb`

```
ThumbsYup.configure do |config|
  config.user_identifier = "your-thumbsyup-website-identifier"

  #INFO: The rest of these are defaults
  #config.thumbs_yup_url = "http://www.thumbsyup.com"
  #config.review_style = "bubble"
  #config.review_color = "blue"
  #config.review_background = "hollow"
  #config.review_size = "med"
end
```

Place in your template:

```
<%= ThumbsYup::ServerEmbed.render_public_reviews(page: params[:page]) %>
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

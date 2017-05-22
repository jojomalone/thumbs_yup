require "spec_helper"

RSpec.describe ThumbsYup do
  before do
    allow(ThumbsYup::ServerEmbed).to receive(:json_review_data).and_return(
      {
        "metadata" => {
          "current_page" => 1,
          "total_count" => 1,
          "per_page" => 30
        },
        "reviews" => [
          {
            "id"=>1,
            "slug"=>"75pk32nge9afjlhwqyczr8tis61m0u",
            "recipient_user_id"=>1,
            "sender_user_id"=>1,
            "body"=> "stubbed review",
            "prefix_name"=>nil,
            "first_name"=>"John",
            "middle_name"=>nil,
            "last_name"=>"Doe",
            "title"=>nil,
            "business_name"=>nil,
            "city"=>nil,
            "state"=>nil,
            "country"=>nil,
            "rating"=>"yup",
            "position"=>1,
            "status"=>"published",
            "confirmation_token"=>nil,
            "confirmed"=>true,
            "created_at"=>"2000-01-01T00:00:00.000Z",
            "updated_at"=>"2000-01-01T00:00:00.000Z",
            "deleted_at"=>nil
          }
        ]
      }
    )
    allow(ThumbsYup::ServerEmbed).to receive(:check_user_identifer!)
  end

  it "has a version number" do
    expect(ThumbsYup::VERSION).not_to be nil
  end

  it "renders a review template for the collection of reviews" do
    reviews_html = ThumbsYup::ServerEmbed.render_public_reviews

    expect(reviews_html).to match %r(<script type='text/javascript')
  end

  it "renders a review template for a single review" do
    reviews_html = ThumbsYup::ServerEmbed.render_public_reviews

    expect(reviews_html).to match /rstyleBlueBubbleHollow/
  end

  it "renders reviews" do
    reviews_html = ThumbsYup::ServerEmbed.render_public_reviews

    expect(reviews_html).to match %r(<div class="rstyleBlueBubbleHollow">.*<\/div>.*\w.*<\/div>)m
  end
end

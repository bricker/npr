require "spec_helper"

describe NPR::Entity::Member do
  json_fixture do
    <<-JSON
      {
        "id": "166481250",
        "promoArt": {
          "refId": "153611356",
          "num": "1"
        },
        "title": {
          "num": "2",
          "$text": "2312"
        },
        "author": {
          "id": "139197905",
          "num": "3",
          "title": {
            "$text": "Kim Stanley Robinson"
          },
          "link": {
            "type": "api",
            "$text": "http://api.npr.org/query?id=139197905&apiKey=MDA1OTI3MjQ5MDEyODUwMTE2MzM1YzNmZA004"
          }
        },
        "bookEdition": {
          "refId": "153611349",
          "num": "4"
        },
        "introText": {
          "num": "5",
          "$text": "<p>A sweeping space opera, <em>2312</em> is about what happens to humanity once we've truly conquered the solar system. Humans have colonized most of the planets and moons in our local volume of space, and it's the end of an interplanetary age of exploration. Political powers are consolidating their territories.</p>"
        },
        "byline": {
          "refId": "166481286",
          "num": "6"
        }
      }
    JSON
  end
  
  before :each do
    @member = NPR::Entity::Member.new(@fixture)
  end
  
  it "sets up attributes" do
    @member.id.should eq 166481250
  end
  
  it "sets up relations" do
    @member.promoArt.should be_a NPR::Entity::PromoArt
    @member.title.should be_a NPR::Entity::Title
    @member.author.should be_a NPR::Entity::Author
    @member.bookEdition.should be_a NPR::Entity::BookEdition
    @member.introText.should be_a NPR::Entity::IntroText
    @member.byline.should be_a NPR::Entity::MemberByline
  end
end
require "spec_helper"

describe NPR::Entity::Byline do
  json_fixture do
    <<-JSON
      {
        "id": "166885535",
        "name": {
          "personId": "134991966",
          "$text": "Julie Bierach"
        },
        "link": [
          {
            "type": "html",
            "$text": "http://news.stlpublicradio.org/people/julie-bierach"
          },
          {
            "type": "api",
            "$text": "http://api.npr.org/query?id=134991966&apiKey=MDA1OTI3MjQ5MDEyODUwMTE2MzM1YzNmZA004"
          }
        ]
      }
    JSON
  end
  
  before :each do
    @byline = NPR::Entity::Byline.new(@fixture)
  end
  
  it "sets up attributes" do
    @byline.id.should be_a Fixnum
    @byline.id.should_not eq 0
  end
  
  it "creates relations" do
    @byline.links.size.should eq 2
    @byline.links.first.should be_a NPR::Entity::Link
    @byline.name.should be_a NPR::Entity::Name
  end
end

require "spec_helper"

describe NPR::Entity::Transcript do
  json_fixture do
    <<-JSON
      {
      "link": {
        "type": "api",
        "$text": "http://api.npr.org/transcript?id=166480907&apiKey=MDA1OTI3MjQ5MDEyODUwMTE2MzM1YzNmZA004"
        }
      }
    JSON
  end

  before :each do
    @transcript = NPR::Entity::Transcript.new(@fixture)
  end

  it "creates relations" do
    @transcript.links[0].should be_a NPR::Entity::Link
  end
end

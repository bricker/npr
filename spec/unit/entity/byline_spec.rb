require "spec_helper"

describe NPR::Entity::Byline do
  json_fixture do
    <<-JSON
      {
        "id": "166481173",
        "name": {
          "$text": "Annalee Newitz"
        }
      }
    JSON
  end
  
  before :each do
    @byline = NPR::Entity::Byline.new(@fixture)
  end
  
  it "sets up attributes" do
    @byline.id.should eq 166481173
    @byline.name.should match /Annalee/
  end
end

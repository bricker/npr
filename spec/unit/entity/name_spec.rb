require "spec_helper"

describe NPR::Entity::Name do
  json_fixture do
    <<-JSON
      {
        "personId": "134991966",
        "$text": "Julie Bierach"
      }
    JSON
  end

  before :each do
    @name = NPR::Entity::Name.new(@fixture)
  end

  it "sets attributes" do
    @name.personId.should eq 134991966
    @name.content.should match /Julie/
  end

  it "uses @content for to_s" do
    @name.to_s.should eq @name.content
  end
end

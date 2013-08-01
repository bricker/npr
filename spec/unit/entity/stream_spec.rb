require "spec_helper"

describe NPR::Entity::Name do
  json_fixture do
    <<-JSON
      {
        "active": "true"
      }
    JSON
  end

  before :each do
    @stream = NPR::Entity::Stream.new(@fixture)
  end

  it "sets attributes" do
    @stream.active.should eq true
    @stream.active?.should eq true
  end
end

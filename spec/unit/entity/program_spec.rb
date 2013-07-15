require "spec_helper"

describe NPR::Entity::Program do
  json_fixture do
    <<-JSON
      {
        "id": "3",
        "code": "ME",
        "$text": "Morning Edition"
      }
    JSON
  end

  before :each do
    @program = NPR::Entity::Program.new(@fixture)
  end

  it "sets up attributes" do
    @program.id.should be_a Integer
    @program.code.should eq "ME"
    @program.content.should eq "Morning Edition"
  end

  it "uses @content for to_s" do
    @program.to_s.should eq "Morning Edition"
  end

  it "responds to title" do
    @program.title.should eq "Morning Edition"
  end
end

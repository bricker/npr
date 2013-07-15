require "spec_helper"

describe NPR::Entity::Title do
  json_fixture do
    <<-JSON
      {
        "num": "2",
        "$text": "2312"
      }
    JSON
  end

  before :each do
    @title = NPR::Entity::Title.new(@fixture)
  end

  it "sets attributes" do
    @title.num.should eq 2
    @title.content.should eq "2312"
  end

  it "uses @content for to_s" do
    @title.to_s.should eq @title.content
  end
end

require "spec_helper"

describe NPR::Entity::Paragraph do
  json_fixture do
    <<-JSON
      {
        "num": "1",
        "$text": "Louisiana music has such a hold on music lovers around the world that nearly every popular artist borrows from it. Or replicates it. Or, some might say, steals from it."
      }
    JSON
  end

  before :each do
    @paragraph = NPR::Entity::Paragraph.new(@fixture)
  end

  it "sets up attributes" do
    @paragraph.num.should eq 1
    @paragraph.content.should match /Louisiana/
  end

  it "uses @content for to_s" do
    @paragraph.to_s.should match /Louisiana/
  end
end

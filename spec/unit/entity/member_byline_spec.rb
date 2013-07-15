require "spec_helper"

describe NPR::Entity::MemberByline do
  json_fixture do
    <<-JSON
      {
        "refId": "166481286",
        "num": "6"
      }
    JSON
  end

  before :each do
    @member_byline = NPR::Entity::MemberByline.new(@fixture)
  end

  it "sets attributes" do
    @member_byline.refId.should eq 166481286
    @member_byline.num.should eq 6
  end
end

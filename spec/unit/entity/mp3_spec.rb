require "spec_helper"

describe NPR::Entity::MP3 do
  json_fixture do
    <<-JSON
      {
        "type": "mp3",
        "$text": "http://pd.npr.org/anon.npr-mp3/npr/totn/2012/12/20121214_totn_01.mp3?orgId=1&topicId=1007&ft=3&f="
      }
    JSON
  end

  before :each do
    @mp3 = NPR::Entity::MP3.new(@fixture)
  end

  it "sets attributes" do
    @mp3.type.should eq "mp3"
    @mp3.content.should match /pd\.npr/
  end

  it "uses @content for #to_s" do
    @mp3.to_s.should eq @mp3.content
  end
end

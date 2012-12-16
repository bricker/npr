require "spec_helper"

describe NPR::Entity::Formats do
  json_fixture do
    <<-JSON
      {
        "mp3": [
          {
            "type": "mp3",
            "$text": "http://pd.npr.org/anon.npr-mp3/npr/totn/2012/12/20121214_totn_01.mp3?orgId=1&topicId=1007&ft=3&f="
          },
          {
            "type": "m3u",
            "$text": "http://api.npr.org/m3u/1167255688-5265f3.m3u?orgId=1&topicId=1007&ft=3&f="
          }
        ],
        "wm": {
          "$text": "http://www.npr.org/templates/dmg/dmg_wmref_em.php?id=167255688&type=1&mtype=WM&orgId=1&topicId=1007&ft=3&f="
        },
        "mediastream": {
          "$text": "rtmp://flash.npr.org/ondemand/mp3:anon.npr-mp3/npr/totn/2012/12/20121214_totn_01.mp3"
        }
      }
    JSON
  end
  
  before :each do
    @formats = NPR::Entity::Formats.new(@fixture)
  end
  
  it "sets up attributes" do
    @formats.wm.should match /npr\.org/
    @formats.rm.should eq nil
    @formats.mediastream.should match /flash/
  end
  
  it "creates relations" do
    @formats.mp3s.size.should eq 2
    @formats.mp3s.first.should be_a NPR::Entity::MP3
  end
end
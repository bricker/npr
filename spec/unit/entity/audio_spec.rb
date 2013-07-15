require "spec_helper"

describe NPR::Entity::Audio do
  json_fixture do
    <<-JSON
      {
        "id": "167255688",
        "type": "primary",
        "title": {},
        "duration": {
          "$text": "465"
        },
        "description": {},
        "format": {
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
        },
        "rightsHolder": {},
        "permissions": {
          "download": {
            "allow": "true"
          },
          "stream": {
            "allow": "true"
          },
          "embed": {
            "allow": "true"
          }
        },
        "stream": {
          "active": "false"
        }
      }
    JSON
  end

  before :each do
    @audio = NPR::Entity::Audio.new(@fixture)
  end

  it "sets attributes" do
    @audio.id.should eq 167255688
    @audio.type.should eq "primary"
    @audio.title.should eq ""
    @audio.duration.should eq 465
    @audio.description.should eq ""
    @audio.rightsHolder.should eq ""
  end

  it "sets permissions" do
    @audio.permissions.should be_a NPR::Entity::Permissions
  end

  it "sets stream" do
    @audio.stream.should eq false
  end

  it "sets format" do
    @audio.formats.should be_a NPR::Entity::Formats
  end
end

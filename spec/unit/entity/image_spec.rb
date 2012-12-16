require "spec_helper"

describe NPR::Entity::Image do
  json_fixture do
    <<-JSON
      {
        "id": "167273389",
        "type": "standard",
        "width": "200",
        "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg?s=12",
        "hasBorder": "false",
        "title": {
          "$text": "Jason Moran chats with Geri Allen on stage."
        },
        "caption": {
          "$text": "Jason Moran chats with Geri Allen on stage."
        },
        "link": {
          "url": ""
        },
        "producer": {},
        "provider": {
          "url": "",
          "$text": "Brendan Hoffman for NPR"
        },
        "copyright": {},
        "enlargement": {
          "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
          "caption": {}
        },
        "crop": [
          {
            "type": "enlargement",
            "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
            "height": "2000",
            "width": "3000"
          },
          {
            "type": "slide",
            "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
            "height": "2000",
            "width": "3000"
          }
        ]
      }
    JSON
  end
  
  before :each do
    @image = NPR::Entity::Image.new(@fixture)
  end
  
  it "sets attributes" do
    @image.id.should eq 167273389
    @image.type.should eq "standard"
    @image.width.should eq 200
    @image.src.should match /media\.npr/
    @image.hasBorder.should eq false
    @image.link.should eq ""
  end
  
  it "sets enlargement" do
    @image.enlargement.should be_a NPR::Entity::Enlargement
  end
  
  it "sets provider" do
    @image.provider.url.should eq ""
    @image.provider.to_s.should match /Brendan./
  end
  
  it "sets crops" do
    @image.crops.size.should eq 2
    @image.crops.first.should be_a NPR::Entity::Crop
  end
  
  it "sets shallow attributes" do
    @image.title.should match /Jason/
    @image.caption.should match /Geri/
    @image.producer.should eq ""
    @image.copyright.should eq ""
  end
end

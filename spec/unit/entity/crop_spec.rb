require "spec_helper"

describe NPR::Entity::Crop do
  json_fixture do
    <<-JSON
      {
        "type": "enlargement",
        "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
        "height": "2000",
        "width": "3000"
      }
    JSON
  end

  before :each do
    @crop = NPR::Entity::Crop.new(@fixture)
  end

  it "sets attributes" do
    @crop.type.should eq "enlargement"
    @crop.src.should match /media\.npr/
    @crop.height.should eq 2000
    @crop.width.should eq 3000
  end
end

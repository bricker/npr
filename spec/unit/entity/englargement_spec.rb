require "spec_helper"

describe NPR::Entity::Enlargement do
  json_fixture do
    <<-JSON
      {
        "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
        "caption": {}
      }
    JSON
  end

  before :each do
    @enlargement = NPR::Entity::Enlargement.new(@fixture)
  end

  it "sets attributes" do
    @enlargement.src.should match /media\.npr/
    @enlargement.caption.should eq ""
  end
end

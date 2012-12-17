require "spec_helper"

describe NPR::Entity::Link do
  json_fixture do
    <<-JSON
      {
        "type": "html",
        "$text": "http://www.npr.org/blogs/thetwo-way/2012/12/11/167019068/sitar-virtuoso-ravi-shankar-dies-at-92?ft=3&f=167019577"
      }
    JSON
  end
  
  before :each do
    @link = NPR::Entity::Link.new(@fixture)
  end
  
  it "sets attributes" do
    @link.type.should eq "html"
    @link.content.should match /npr\.org/
  end
  
  it "uses @content for to_s" do
    @link.to_s.should match /npr\.org/
  end
  
  #--------------------
  
  it "responds to type methods" do
    @link.html?.should eq true
    @link.api?.should eq false
    @link.short?.should eq false
  end
end

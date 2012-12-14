require "spec_helper"

describe NPR::Entity::Link do
  before :each do
    @link = NPR::Entity::Link.new({"$type" => "google.com", "type" => "html"})
  end
  
  it "sets attributes" do
    @link.type.should eq "html"
    @link.content.should eq "google.com"
  end
  
  it "uses @content for to_s" do
    @link.to_s.should eq "google.com"
  end
end

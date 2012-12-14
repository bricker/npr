require "spec_helper"

describe NPR::Base do
  describe "::shallow_attribute" do
    it "assigns shallow_attributes" do
      NPR::Base.shallow_attribute("link", "text")
      NPR::Base._shallow_attributes.should eq ["link", "text"]
    end
  end
end

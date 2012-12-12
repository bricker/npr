require "spec_helper"

# I just want to make sure these exist
describe "Errors" do
  describe NPR::ClientError do
    it("exists") { true }
  end
  
  describe NPR::ServerError do
    it("exists") { true }
  end
  
  describe NPR::NotConfiguredError do
    it("exists") { true }
  end
end

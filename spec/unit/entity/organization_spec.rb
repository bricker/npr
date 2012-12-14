require "spec_helper"

describe NPR::Entity::Organization do
  json_fixture do
    <<-JSON
      {
        "orgId": "1",
        "orgAbbr": "NPR",
        "name": {
          "$text": "National Public Radio"
        },
        "website": {
          "$text": "http://www.npr.org/"
        }
      }
    JSON
  end
    
  before :each do
    @organization = NPR::Entity::Organization.new(@fixture)
  end
  
  it "sets up attributes" do
    @organization.name.should match /National/
    @organization.website.should match /npr\.org/
    @organization.orgId.should eq 1
    @organization.orgAbbr.should eq "NPR"
  end
end

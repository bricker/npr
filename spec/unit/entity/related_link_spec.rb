require "spec_helper"

describe NPR::Entity::RelatedLink do
  json_fixture do
   <<-JSON
      {
        "id": "167020072",
        "type": "internal",
        "caption": {
          "$text": " Ravi Shankar At 90: The Man And His Music"
        },
        "link": [
          {
            "type": "html",
            "$text": "http://www.npr.org/2010/04/06/125507150/ravi-shankar-at-90-the-man-and-his-music?ft=3&f=167019577"
          },
          {
            "type": "api",
            "$text": "http://api.npr.org/query?id=125507150&apiKey=MDA1OTI3MjQ5MDEyODUwMTE2MzM1YzNmZA004"
          }
        ]
      }
    JSON
  end
  
  #----------------------------
  
  describe "relations" do
    it "has links" do
      related_link = NPR::Entity::RelatedLink.new(@fixture)
      related_link.links.size.should eq 2
      related_link.links.first.should be_a NPR::Entity::Link 
    end
  end

  #----------------------------
  
  describe "attributes" do
    before :each do
      @related_link = NPR::Entity::RelatedLink.new(@fixture)
    end
    
    it "has a caption" do
      @related_link.caption.should match /Ravi Shankar/
    end
    
    it "has a type" do
      @related_link.type.should eq "internal"
    end
    
    it "has an id" do
      @related_link.id.should be_a Integer
    end
  end
end

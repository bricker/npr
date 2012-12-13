require "spec_helper"

describe NPR::Story do
  describe "::find" do
    before :all do
      NPR.config.apiKey = "key"
    end
    
    before :each do
      @id = 167019577
    end
    
    after :all do
      NPR.config.apiKey = nil
    end
    
    it "instantiates a new story" do
      mock_response "nprml/01_story_full_media.xml" do
        story = NPR::Story.find(@id)
        story.should be_a NPR::Story
      end
    end
    
    it "typecasts the attributes that need it" do
      mock_response "nprml/01_story_full_media.xml" do
        story = NPR::Story.find(@id)
        story.id.should be_a Fixnum
        story.pubDate.should be_a Time
      end
    end
  end
end

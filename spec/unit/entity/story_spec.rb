require "spec_helper"

describe NPR::Entity::Story do
  config!(:apiKey => "key")
  
  #--------------------------
  
  describe "relations" do
    before :each do
      @story = mock_response "json/01_story_full_media.json" do
        NPR::Story.find(999)
      end
    end
    
    it "sets up images" do
      @story.images.should_not be_empty
      @story.images.first.should be_a NPR::Entity::Image
    end
    
    it "sets up bylines" do
      @story.bylines.should_not be_empty
      @story.bylines.first.should be_a NPR::Entity::Byline
    end
    
    it "sets up organizations" do
      @story.organizations.should_not be_empty
      @story.organizations.first.should be_a NPR::Entity::Organization
    end
    
    it "sets up links" do
      @story.links.should_not be_empty
      @story.links.first.should be_a NPR::Entity::Link
    end
    
    it "sets up related_links" do
      @story.related_links.should_not be_empty
      @story.related_links.first.should be_a NPR::Entity::RelatedLink
    end
    
    it "sets up pull_quotes" do
      # The fixture doesn't have any pull quotes
      # TODO Get a fixtute with pull quotes
      @story.pull_quotes.should eq []
    end
    
    it "sets up shows" do
      @story.shows.should_not be_empty
      @story.shows.first.should be_a NPR::Entity::Show
    end
  end
  
  #--------------------------
  
  describe "attributes" do
    before :each do
      @story = mock_response "json/01_story_full_media.json" do
        NPR::Story.find(999)
      end
    end
    
    it "generates title" do
      @story.title.should match /Ravi Shankar/
    end
    
    it "generates partnerId" do
      @story.partnerId.should be_a Integer
    end
    
    it "generates subtitle" do
      @story.subtitle.should be_a String
    end
    
    it "generates shortTitle" do
      @story.shortTitle.should be_a String
    end
    
    it "generates miniTeaser" do
      @story.miniTeaser.should match /sitar/
    end
    
    it "generates slug" do
      @story.slug.should match /Record/
    end
    
    it "generates storyDate" do
      @story.storyDate.should be_a Time
    end
    
    it "generates pubDate" do
      @story.pubDate.should be_a Time
    end
    
    it "generates lastModifiedDate" do
      @story.lastModifiedDate.should be_a Time
    end
    
    it "generates keywords" do
      @story.keywords.should be_a String
    end
    
    it "generates priorityKeywords" do
      @story.priorityKeywords.should be_a String
    end
    
    it "generates fullText" do
      @story.fullText.should match /Ravi Shankar/
    end
  end
  
  describe "::find" do
    it "instantiates a new story" do
      story = mock_response "json/01_story_full_media.json" do
        NPR::Entity::Story.find(167019577)
      end
      
      story.should be_a NPR::Entity::Story
    end
    
    it "typecasts the attributes that need it" do
      story = mock_response "json/01_story_full_media.json" do
        NPR::Entity::Story.find(167019577)
      end
      
      story.id.should be_a Fixnum
      story.pubDate.should be_a Time
    end
    
    context "with multiple ids" do
      it "only returns the first story" do
        story = mock_response "json/06_story_multiple_ids.json" do
          NPR::Entity::Story.find("167055503,166956822")
        end
        
        story.should be_a NPR::Entity::Story
      end
    end
    
    context "with messages in the response" do
      it "returns the messages" do
        response = mock_response "json/04_invalid_id.json" do
          NPR::Entity::Story.find(000)
        end
        
        response.should be_a Array
        response.first.should be_a NPR::API::Message
      end
    end
  end

  #--------------------

  describe "::find_by_id" do    
    context "with messages in the response" do
      it "returns nil" do
        response = mock_response "json/04_invalid_id.json" do
          NPR::Entity::Story.find_by_id(000)
        end
        
        response.should eq nil
      end
    end
  end
  
  #--------------------
  
  describe "::where" do
    it "creates a new QueryBuilder object and runs #where on it" do
      args = { :id => 9999 }
      query = NPR::Entity::Story.where(args)
      query._klass.should eq NPR::Entity::Story
      query.builder[:conditions].should eq args
    end
  end
  
  #--------------------
  
  describe "::order" do
    it "creates a new QueryBuilder object and runs #order on it" do
      args = "date descending"
      query = NPR::Entity::Story.order(args)
      query.builder[:order].should eq args
    end
  end
  
  #--------------------
  
  describe "::limit" do
    it "creates a new QueryBuilder object and runs #limit on it" do
      args = 10
      query = NPR::Entity::Story.limit(args)
      query.builder[:limit].should eq args
    end
  end
  
  #--------------------
  
  describe "::offset" do
    it "creates a new QueryBuilder object and runs #offset on it" do
      args = 100
      query = NPR::Entity::Story.offset(args)
      query.builder[:offset].should eq args
    end
  end  
end

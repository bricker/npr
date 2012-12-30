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
    
    it "sets up relations" do
      @story.images.first.should be_a NPR::Entity::Image
      @story.bylines.first.should be_a NPR::Entity::Byline
      @story.organizations.first.should be_a NPR::Entity::Organization
      @story.links.first.should be_a NPR::Entity::Link
      @story.related_links.first.should be_a NPR::Entity::RelatedLink
      @story.shows.first.should be_a NPR::Entity::Show

      # The fixture doesn't have these attributes
      # TODO Get a fixtute with these attributes
      @story.pull_quotes.should eq []
      @story.members.should eq []
      @story.promo_arts.should eq []
      @story.list_texts.should eq []
      @story.book_editions.should eq []
      
      @story.transcript.should eq nil
    end
  end
  
  #--------------------------
  
  describe "attributes" do
    before :each do
      @story = mock_response "json/01_story_full_media.json" do
        NPR::Story.find(999)
      end
    end
    
    it "Sets up attributes" do
      @story.title.should match /Ravi Shankar/
      @story.partnerId.should be_a Integer
      @story.subtitle.should be_a String
      @story.shortTitle.should be_a String
      @story.miniTeaser.should match /sitar/
      @story.slug.should match /Record/
      @story.storyDate.should be_a Time
      @story.pubDate.should be_a Time
      @story.lastModifiedDate.should be_a Time
      @story.keywords.should be_a String
      @story.priorityKeywords.should be_a String
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
  
  #--------------------
  
  describe "#primary_image" do
    before :each do
      @story = mock_response "json/02_story_multiple_images.json" do
        NPR::Story.find(999)
      end
    end
    
    it "finds the first image with type 'primary'" do
      @story.primary_image.type.should eq "primary"
    end
    
    it "falls back to just the first image if no primary image is available" do
      # Remove the type "primary" image from the json response
      @story.images.delete_if { |i| i.type == "primary" }
      @story.primary_image.type.should eq "standard"
    end
  end
  
  #--------------------
  
  describe "#link_for" do
    before :each do
      @story = mock_response "json/02_story_multiple_images.json" do
        NPR::Story.find(999)
      end
    end
    
    it "finds the link for the passed-in type if it exists" do
      @story.link_for("html").should be_a NPR::Entity::Link
    end
    
    it "is nil if the type isn't present" do
      @story.link_for("nothing").should eq nil
    end
  end
  
  #--------------------
  
end

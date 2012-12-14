require "spec_helper"

describe NPR::Entity::Story do
  describe "::find" do
    config!(:apiKey => "key")

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
    config!(:apiKey => "key")
    
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

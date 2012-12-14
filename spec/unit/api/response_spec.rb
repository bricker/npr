require "spec_helper"
require "json"

describe NPR::API::Response do
  before :each do
    @client = NPR::API::Client.new(:apiKey => "key")
  end
  
  describe "messages" do
    it "generates messages" do
      response = mock_response "json/04_invalid_id.json" do
        @client.query(:id => 999)
      end
      
      response.messages.size.should eq 1
      response.messages.first.id.should eq "201"
    end
    
    it "adds the messages association even if there aren't any" do
      response = mock_response "json/01_story_full_media.json" do
        @client.query(:id => 999)
      end
    
      response.messages.should eq []
    end
  end
  
  describe "list" do
    it "is generated" do
      response = mock_response "json/01_story_full_media.json" do
        @client.query(:id => 999)
      end
    
      response.list.should be_a NPR::Entity::List
    end
  
    it "isn't generated no list node was present" do
      response = mock_response "json/05_no_api_key.json" do
        @client.query(:id => 999)
      end
    
      response.list.should eq nil
    end
  end
end

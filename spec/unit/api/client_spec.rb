require "spec_helper"

describe NPR::API::Client do
  describe "params" do
    it "sets @apiKey on initialize and removes it from the params if passed in" do
      client = NPR::API::Client.new(:apiKey => "key")
      client.instance_variable_get(:@apiKey).should eq "key"
      client.params.keys.should_not include :apiKey
    end
    
    it "sets @url on initialize" do
      client = NPR::API::Client.new(:url => "http://api.publish2.com")
      client.url.should eq "http://api.publish2.com"
      client.params.keys.should_not include :url
    end

    it "falls back to default NPR API root if URL not passed in" do
      client = NPR::API::Client.new
      client.url.should eq NPR::Configuration::API_ROOT
    end

    it "uses global config" do
      NPR.config.sort = "super sort"
      client = NPR::API::Client.new
      client.params[:sort].should eq "super sort"
    end
    
    it "passed-in params take precedence over global config" do
      NPR.config.sort = "global sort"
      client = NPR::API::Client.new(:sort => "local sort")
      client.params[:sort].should eq "local sort"
    end
  end
  
  #-----------------
  
  describe "#query" do
    it "raises NotConfiguredError if apiKey is blank" do
      client = NPR::API::Client.new
      lambda { client.query }.should raise_error NPR::NotConfiguredError
    end

    it 'uses the passed-in path if available' do
      respond_with("json/01_story_full_media.json", uri: %r|api\.publish2\.com/list/stories|)

      client = NPR::API::Client.new(:apiKey => "key", :url => "http://api.publish2.com")

      # If this fails, it should be caught by FakeWeb.allow_net_connect = false
      response = client.query(:path => "/list/stories")
      # But just incase...
      response.instance_variable_get(:@_response).env[:url].to_s.should match %r|api\.publish2\.com/list/stories|
    end
  end
end

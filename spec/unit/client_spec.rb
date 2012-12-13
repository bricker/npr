require "spec_helper"

describe NPR::Client do
  describe "params" do
    it "sets @apiKey on initialize and removes it from the params if passed in" do
      client = NPR::Client.new(:apiKey => "key")
      client.instance_variable_get(:@apiKey).should eq "key"
      client.params.keys.should_not include :apiKey
    end
    
    it "uses global config" do
      NPR.config.sort = "super sort"
      client = NPR::Client.new
      client.params[:sort].should eq "super sort"
    end
    
    it "passed-in params take precedence over global config" do
      NPR.config.sort = "global sort"
      client = NPR::Client.new(:sort => "local sort")
      client.params[:sort].should eq "local sort"
    end
  end
  
  #-----------------
  
  describe "#query" do
    it "raises NotConfiguredError if apiKey is blank" do
      client = NPR::Client.new
      lambda { client.query }.should raise_error NPR::NotConfiguredError
    end
    
    context "nprml" do
      it "returns a result in hash format" do
      end
    end
    
    context "json" do
      it "returns a result in hash format" do
      end
    end    
  end
end

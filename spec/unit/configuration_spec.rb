require "spec_helper"

describe NPR::Configuration do
  describe "NPR.configure" do
    after :each do
      NPR.instance_variable_set :@config, nil
    end
    
    it "takes a block to set global configuration" do
      NPR.configure do |config|
        config.sort = "cool sorting, bro"
      end
    
      NPR.config.sort.should eq "cool sorting, bro"
      NPR.config.apiKey.should eq nil
    end
  end
  
  describe "NPR.config" do
    it "creates a new NPR::Configure object" do
      config = NPR.config
      config.should be_a NPR::Configuration
      NPR.config.should equal config 
    end
  end
  
  #------------------
  
  describe "#to_hash" do
    it "converts the config to a hash" do
      config = NPR::Configuration.new
      config.sort   = "date"
      config.apiKey = "key"
  
      config.to_hash.should eq Hash[:sort => "date", :apiKey => "key"]
    end
  end
  
  #------------------
  
  describe "#merge" do
    it "turns it into a hash and merges it with the passed-in hash" do
      config = NPR::Configuration.new
      config.sort   = "date"
      config.apiKey = "key"
      
      config.merge(:title => "List").should eq Hash[
        :title => "List",
        :sort => "date", 
        :apiKey => "key" 
      ]
    end
  end
end

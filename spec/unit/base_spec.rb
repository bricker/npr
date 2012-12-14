require "spec_helper"

describe NPR::Base do
  describe "::shallow_attribute" do
    before :all do
      NPR::Base.shallow_attribute("link", "text")
    end
    
    after :all do
      NPR::Base._should_attributes = []
    end
    
    it "assigns shallow_attributes" do
      NPR::Base._shallow_attributes.should eq ["link", "text"]
    end
    
    it "defines accessors" do
      base = NPR::Base.new
      base.should respond_to :link
      base.should respond_to :text
      base.should respond_to :link=
      base.should respond_to :text=
    end
  end
  
  #--------------------
  
  describe "::has_many" do
    before :all do
      NPR::Base.has_many("objects", :key => "object", :class_name => Object)
    end
    
    after :all do
      NPR::Base._relations = []
    end
    
    it "assigns relations" do
      NPR::Base._relations.should eq [{ 
        :name       => "objects", 
        :key        => "object", 
        :class_name => Object
      }]
    end
    
    it "defines accessors" do
      base = NPR::Base.new
      base.should respond_to :objects
      base.should respond_to :objects=
    end
  end
end

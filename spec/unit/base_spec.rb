require "spec_helper"

describe NPR::Base do
  describe "::shallow_attribute" do
    before :all do
      @reset = NPR::Base.send :_shallow_attributes
      NPR::Base.shallow_attribute("banjo", "kazooie")
    end
    
    after :all do
      NPR::Base.send :_shallow_attributes=, @reset
    end
        
    it "assigns shallow_attributes" do
      NPR::Base._shallow_attributes.should eq ["banjo", "kazooie"]
    end
    
    it "defines accessors" do
      base = NPR::Base.new
      base.should respond_to :banjo
      base.should respond_to :kazooie
      base.should respond_to :banjo=
      base.should respond_to :kazooie=
    end
  end
  
  #--------------------
  
  describe "::has_many" do
    before :all do
      @reset = NPR::Base.send :_relations
      NPR::Base.has_many("objects", :key => "object", :class_name => Object)
    end
    
    after :all do
      NPR::Base.send :_relations=, @reset
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
    
    it "sets reader to array on first access" do
      base = NPR::Base.new
      base.instance_variable_get(:@objects).should eq nil
      base.objects.should eq []
      base.instance_variable_get(:@objects).should eq []
    end
  end
end

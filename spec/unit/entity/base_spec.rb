require "spec_helper"

describe NPR::Entity::Base do
  describe "::shallow_attribute" do
    before :all do
      @reset = NPR::Entity::Base.send :_shallow_attributes
      NPR::Entity::Base.shallow_attribute("banjo", "kazooie")
    end
    
    after :all do
      NPR::Entity::Base.send :_shallow_attributes=, @reset
    end
        
    it "assigns shallow_attributes" do
      NPR::Entity::Base._shallow_attributes.should eq ["banjo", "kazooie"]
    end
    
    it "defines accessors" do
      entity = NPR::Entity::Base.new
      entity.should respond_to :banjo
      entity.should respond_to :kazooie
      entity.should respond_to :banjo=
      entity.should respond_to :kazooie=
    end
  end
  
  #--------------------
  
  describe "::has_many" do
    before :all do
      @reset = NPR::Entity::Base.send :_has_many_relations
      NPR::Entity::Base.has_many("objects", :key => "object", :class_name => Object)
    end
    
    after :all do
      NPR::Entity::Base.send :_has_many_relations=, @reset
    end
    
    it "assigns relations" do
      NPR::Entity::Base._has_many_relations.should eq [{ 
        :name       => "objects", 
        :key        => "object", 
        :class_name => Object
      }]
    end
    
    it "defines accessors" do
      entity = NPR::Entity::Base.new
      entity.should respond_to :objects
      entity.should respond_to :objects=
    end
    
    it "sets reader to array on first access" do
      entity = NPR::Entity::Base.new
      entity.instance_variable_get(:@objects).should eq nil
      entity.objects.should eq []
      entity.instance_variable_get(:@objects).should eq []
    end
  end
  
  #--------------------
  
  describe "::has_one" do
    before :all do
      @reset = NPR::Entity::Base.send :_has_one_relations
      NPR::Entity::Base.has_one "object", :class_name => Object
    end
    
    after :all do
      NPR::Entity::Base.send :_has_one_relations=, @reset
    end
    
    it "assigns relations" do
      NPR::Entity::Base._has_one_relations.should eq [{
        :name       => "object", 
        :key        => "object", 
        :class_name => Object
      }]
    end
    
    it "defines accessor" do
      entity = NPR::Entity::Base.new
      entity.should respond_to :object
      entity.should respond_to :object=
    end
  end
end

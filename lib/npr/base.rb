##
# NPR::Base
#
# Class for all NPR Objects to inherit from
#
module NPR
  class Base
    
    #------------------
    # Attributes that are being typecast to Ruby classes
    ATTR_TYPES = {
      "id"               => Fixnum,
      "partnerId"        => Fixnum,
      "storyDate"        => Time, 
      "pubDate"          => Time,
      "lastModifiedDate" => Time
    }
    
    #-----------------

    class << self
      
      #-----------------
      # A "shallow attribute" is one that only contains the "$text"
      # node. Use this class method to define which attributes those
      # are.
      #
      # Example:
      #
      #   { "link": { "$text": "www.google.com" } }
      #   
      #   shallow_attribute "link"
      #
      def shallow_attribute(*attrs)
        _shallow_attributes.push *attrs
        attr_accessor *attrs
      end

      #-----------------
      # Define a relationship
      # Similar to ActiveRecord's +has_many+
      #
      # Arguments: 
      #
      # * name (String) - the name of the relation
      # * options (Hash)
      #     * class_name (Class) - the class for the related objects
      #     * key (String) - the JSON key that holds this relation
      #
      # Example:
      #
      #   has_many "links", key: "link", class_name: NPR::Link
      #
      def has_many(name, options)
        class_name = options[:class_name]
        key        = options[:key]
        
        relation = { 
          :name       => name, 
          :class_name => class_name,
          :key        => key
        }
        
        # Define getter and setter for this attribute
        # Forces the relation into an empty array when
        # it's first accessed.
        attr_writer name
        define_method name do
          instance_variable_get("@#{name}") || instance_variable_set("@#{name}", [])
        end
        
        _relations.push relation
      end
      
      #-----------------
      
      def _shallow_attributes
        @shallow_attributes ||= []
      end
      
      #-----------------
      
      def _relations
        @relations ||= []
      end

      #-----------------
      
      private

      #-----------------
      
      attr_writer :_shallow_attributes, :_relations
    end
    
    
    #-----------------
    # Override this
    def initialize(json={})
      @_json = json
    end

    #-----------------
    
    private

    #-----------------
    
    def attr_typecast(key, value)
      if type = ATTR_TYPES[key]
        value.cast_to(type)
      else
        value
      end
    end
    
    #-----------------
    # Extract the defined shallow_attributes from the JSON
    # and set the corresponding attribute.
    #
    # If the JSON doesn't contain a key for an attribute,
    # then attribute will remain at its default state (nil).
    #
    # Arguments: Hash of the JSON for this object
    #
    # Example:
    #
    #   def initialize(json)
    #     extract_shallow_attributes(json)
    #   end
    #
    def extract_shallow_attributes(json)
      self.class._shallow_attributes.each do |key|
        if node = json[key]
          send "#{key}=", attr_typecast(key, node["$text"])
        end
      end
    end

    #-----------------
    # Populate the relations based on 
    def create_relations(json)
      self.class._relations.each do |relation|
        collection = []
        
        if node = json[relation[:key]]
          node.each do |obj| 
            collection.push relation[:class_name].new(obj)
          end
        end
        
        send "#{relation[:name]}=", collection
      end
    end
  end
end

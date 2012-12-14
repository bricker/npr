##
# NPR::Concern::ShallowAttributes
#
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
module NPR
  module Concern
    module ShallowAttributes
      include AttrTypecast
      
      def self.included(base)
        base.extend ClassMethods
      end

      #-----------------

      module ClassMethods
        def shallow_attribute(*attrs)
          _shallow_attributes.push *attrs
          attr_accessor *attrs
        end
        
        #-----------------
      
        def _shallow_attributes
          @shallow_attributes ||= []
        end
        
        #-----------------
        
        private
        attr_writer :_shallow_attributes
      end
      
      #-----------------
      
      private
      
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
            send "#{key}=", attr_typecast(key, node["$text"].to_s)
          end
        end
      end
    end # ShallowAttribute
  end # Concern
end # NPR
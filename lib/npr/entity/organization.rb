##
# NPR::Entity::Organization
#
module NPR
  module Entity
    class Organization < Base
      attr_accessor :orgId, :orgAbbr
      shallow_attribute "name", "website"
      
      def initialize(json)
        extract_shallow_attributes(json)
        
        @orgId   = json["orgId"].to_i
        @orgAbbr = json["orgAbbr"]
      end
    end # Organization
  end # Entity
end # NPR

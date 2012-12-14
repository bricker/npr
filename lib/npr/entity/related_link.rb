##
# NPR::Entity::RelatedLink
#
module NPR
  module Entity
    class RelatedLink < Base
      attr_accessor :id, :type
      
      has_many "links", :key => "link", :class_name => NPR::Entity::Link
      shallow_attribute "caption"
      
      def initialize(json)
        extract_shallow_attributes(json)
        create_relations(json)
        
        @id   = json["id"].to_i
        @type = json["type"]
      end
    end # RelatedLink
  end # Entity
end # NPR

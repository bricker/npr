##
# NPR::Entity::RelatedLink
#
module NPR
  module Entity
    class RelatedLink < Base
      include NPR::Concern::LinksAssociation

      attr_accessor :id, :type
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

##
# NPR::Entity::Parent
#
module NPR
  module Entity
    class Parent < Base
      include NPR::Concern::LinksAssociation

      attr_accessor :id, :type
      shallow_attribute "title"

      #-------------------

      def initialize(json)
        @id      = json["id"].to_i
        @type    = json["type"]

        extract_shallow_attributes(json)
        create_relations(json)
      end
    end # Program
  end # Entity
end # NPR

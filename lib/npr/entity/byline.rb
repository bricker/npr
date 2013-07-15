##
# NPR::Entity::Byline
#
module NPR
  module Entity
    class Byline < Base
      attr_accessor :id
      has_many "links", :key => "link", :class_name => NPR::Entity::Link
      has_one "name", :class_name => NPR::Entity::Name

      #-----------------

      def initialize(json)
        @id = json["id"].to_i
        create_relations(json)
      end
    end # Byline
  end # Entity
end # NPR

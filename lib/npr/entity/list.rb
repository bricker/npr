##
# NPR::Entity::List
#
module NPR
  module Entity
    class List < Base
      include NPR::Concern::LinksAssociation
      has_many "stories", :key => "story", :class_name => NPR::Entity::Story

      #------------------

      shallow_attribute(
        "title",
        "teaser",
        "miniTeaser"
      )

      #------------------

      def initialize(json)
        extract_shallow_attributes(json)
        create_relations(json)
      end
    end # List
  end # Entity
end # NPR

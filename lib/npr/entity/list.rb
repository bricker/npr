##
# NPR::Entity::List
#
module NPR
  module Entity
    class List < Base
      #------------------

      has_many "links",   :key => "link",  :class_name => NPR::Entity::Link
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

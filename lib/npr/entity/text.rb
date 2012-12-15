##
# NPR::Entity::Text
#
module NPR
  module Entity
    class Text < Base
      has_many "paragraphs", :key => "paragraph", :class_name => NPR::Entity::Paragraph

      #-----------------
      
      def initialize(json)
        create_relations(json)
      end
      
      #-----------------
      
      def to_s
        @paragraphs.map(&:to_s).join("\n")
      end
    end # Text
  end # Entity
end # NPR

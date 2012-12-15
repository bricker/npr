##
# NPR::Entity::Text
#
module NPR
  module Entity
    class Text < Base
      has_many "paragraphs", :key => "paragraph", :class_name => NPR::Entity::Paragraph

      #-----------------
      
      def initialize(json)
        create_relations(json["text"])
      end
      
      #-----------------
      
      def to_s
        @paragraphs.map(&:to_s).join("\n")
      end
    end # Text

    #-----------------
    # NPR::Entity::TextWithHTML
    #
    class TextWithHtml < Text
      def initialize(json)
        create_relations(json["textWithHtml"])
      end
    end # TextWithHtml
  end # Entity
end # NPR

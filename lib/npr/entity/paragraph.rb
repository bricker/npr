##
# NPR::Entity::Paragraph
#
# NPR splits every paragraph into separate
# database entries. This object will represent
# a single paragraph for a story.
#
module NPR
  module Entity
    class Paragraph < Base
      attr_reader :num, :content

      #---------------------
    
      def initialize(json={})
        @content = json["$text"]
        @num     = json["num"]
      end

      #---------------------
    
      def to_s
        @content
      end
    end # Paragraph
  end # Entity
end # NPR

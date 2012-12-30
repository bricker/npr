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
      attr_accessor :num, :content

      #---------------------
    
      def initialize(json)
        @content = json["$text"]
        @num     = json["num"].to_i
      end

      #---------------------
    
      def to_s
        @content.to_s
      end
    end # Paragraph
  end # Entity
end # NPR

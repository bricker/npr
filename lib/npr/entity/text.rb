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

      #-----------------
      # Turn this text node into an embeddable
      # block of HTML.
      #
      # This is useful if the fullText attribute
      # is missing on an NPR Story. It will not
      # be as robust as a full HTML body from
      # NPR, but it will work in most cases.
      #
      def to_html
        result = ""

        @paragraphs.each do |paragraph|
          result << "<p>" + paragraph.to_s + "</p>\n"
        end

        result
      end
    end # Text
  end # Entity
end # NPR

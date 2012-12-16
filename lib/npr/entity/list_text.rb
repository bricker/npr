##
# NPR::Entity::ListText
#
module NPR
  module Entity
    class ListText < Base
      attr_accessor :id, :tag
      has_many "paragraphs", :key => "paragraph", :class_name => NPR::Entity::Paragraph
      
      #-------------------
      
      def initialize(json)
        @id = json["id"].to_i
        @tag = json["tag"]
        create_relations(json)
      end
    end # ListText
  end # Entity
end # NPR

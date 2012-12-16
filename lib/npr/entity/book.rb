##
# NPR::Entity::Book
#
module NPR
  module Entity
    class Book < Base
      attr_accessor :id
      shallow_attribute "title"
      has_one "link", :class_name => NPR::Entity::Link
      
      #---------------------
      
      def initialize(json)
        @id = json["id"].to_i

        extract_shallow_attributes(json)
        create_relations(json)
      end
    end # Book
  end # Entity
end # NPR

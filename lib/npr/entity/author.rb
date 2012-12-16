##
# NPR::Entity::Author
#
module NPR
  module Entity
    class Author < Base
      attr_accessor :id, :num
      shallow_attribute "title"
      has_one "link", :class_name => NPR::Entity::Link
      
      #-----------------
      
      def initialize(json)
        @id  = json["id"].to_i
        @num = json["num"].to_i
        
        create_relations(json)
        extract_shallow_attributes(json)
      end
    end # Author
  end # Entity
end # NPR

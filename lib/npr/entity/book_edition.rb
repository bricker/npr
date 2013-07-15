##
# NPR::Entity::BookEdition
#
module NPR
  module Entity
    class BookEdition < Base
      attr_accessor :id, :format_num
      shallow_attribute "isbn", "publisher", "pubDate", "pagination", "listPrice"
      has_one "book", :class_name => NPR::Entity::Book

      #---------------------
      # Note that the "format" property is represented on this
      # object as "format_num", because of Kernel's "format"
      def initialize(json)
        @id = json["id"].to_i

        if json["format"]
          @format_num = json["format"]["$text"].to_i
        end

        extract_shallow_attributes(json)
        create_relations(json)
      end
    end # BookEdition
  end # Entity
end # NPR

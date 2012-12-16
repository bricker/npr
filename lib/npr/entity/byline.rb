##
# NPR::Entity::Byline
#
module NPR
  module Entity
    class Byline < Base
      attr_accessor :id
      shallow_attribute "name"
      
      #-----------------
      
      def initialize(json)
        @id = json["id"].to_i
        extract_shallow_attributes(json)
      end
    end # Byline
  end # Entity
end # NPR

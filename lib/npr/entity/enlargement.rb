##
# NPR::Entity::Enlargement
#
module NPR
  module Entity
    class Enlargement < Base
      attr_accessor :src
      shallow_attribute "caption"
      
      #---------------
      
      def initialize(json)
        @src = json["src"]
        extract_shallow_attributes(json)
      end
    end # Enlargement
  end # Entity
end # NPR

##
# NPR::Entity::Namew
#
# Byline name
#
module NPR
  module Entity
    class Name < Base
      attr_accessor :personId, :content
      
      #-------------------
      
      def initialize(json)
        @personId = json["personId"].to_i
        @content  = json["$text"]
      end
      
      #-------------------
      
      def to_s
        @content
      end
    end # Name
  end # Entity
end # NPR

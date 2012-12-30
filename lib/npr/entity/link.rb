##
# NPR::Entity::Link
#
module NPR
  module Entity
    class Link < Base
      attr_accessor :type, :content
      
      #---------------------
    
      def initialize(json)
        @content = json["$text"]
        @type    = json["type"]
      end

      #---------------------
    
      def to_s
        @content.to_s
      end
    end # Link
  end # Entity
end # NPR

##
# NPR::Entity::Link
#
module NPR
  module Entity
    class Link < Base
      attr_reader :type, :content
      
      #---------------------
    
      def initialize(json)
        @content = json["$type"]
        @type    = json["type"]
      end

      #---------------------
    
      def to_s
        @content
      end
    end # Link
  end # Entity
end # NPR

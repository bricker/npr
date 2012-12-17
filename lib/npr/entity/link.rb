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
        @content
      end
      
      #---------------------
      
      def api?
        @type == "api"
      end

      #---------------------
      
      def html?
        @type == "html"
      end

      #---------------------
      
      def short?
        @type == "short"
      end
    end # Link
  end # Entity
end # NPR

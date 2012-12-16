##
# NPR::Entity::MP3
#
module NPR
  module Entity
    class MP3 < Base
      attr_accessor :type, :content
      
      #-----------------
      
      def initialize(json)
        @type    = json["type"]
        @content = json["$text"]
      end
      
      #-----------------
      
      def to_s
        @content
      end
    end # MP3
  end # Entity
end # NPR

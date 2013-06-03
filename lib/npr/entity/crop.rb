##
# NPR::Entity::Crop
#
module NPR
  module Entity
    class Crop < Base
      attr_accessor :type, :src, :width, :height
      
      #---------------
      
      def initialize(json)
        @type   = json["type"]
        @src    = json["src"]
        @width  = json["width"].to_i
        @height = json["height"].to_i
      end
    end # Crop
  end # Entity
end # NPR

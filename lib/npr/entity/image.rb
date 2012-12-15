##
# NPR::Entity::Image
#
module NPR
  module Entity
    class Image < Base
      attr_accessor :id, :type, :width, :src, :hasBorder, :link, :provider
      
      #-------------
      
      shallow_attribute "title", "caption", "producer", "copyright"

      #-------------
      # NOTE that the "link" attribute here is not cast into a Link
      # object, and the "url" parameter is ignored. Instead, just 
      # calling +image.link+ will return the URL parameter.
      def initialize(json)
        @id        = json["id"].to_i
        @type      = json["type"]
        @width     = json["width"].to_i
        @src       = json["src"]
        @hasBorder = json["hasBorder"] == "true" ? true : false
        
        if json["link"] && json["link"]["url"]
          @link = json["link"]["url"]
        end
        
        if json["provider"]
          @provider = NPR::Entity::Provider.new(json["provider"])
        end
        
        extract_shallow_attributes(json)
      end
    end # Image
  end # Entity
end # NPR

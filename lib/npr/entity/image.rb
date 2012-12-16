##
# NPR::Entity::Image
#
module NPR
  module Entity
    class Image < Base
      attr_accessor :id, :type, :width, :src, :hasBorder, :link, :provider, :enlargement
      shallow_attribute "title", "caption", "producer", "copyright"
      has_many "crops", :key => "crop", :class_name => NPR::Entity::Crop
      
      #-------------
      # NOTE that the "link" attribute here is not cast into a Link
      # object, and the "url" parameter is ignored. Instead, just 
      # calling +image.link+ will return the URL parameter.
      def initialize(json)
        @id        = json["id"].to_i
        @type      = json["type"]
        @width     = json["width"].to_i
        @src       = json["src"]
        @hasBorder = json["hasBorder"] == "true"
        
        if json["link"]
          @link = json["link"]["url"]
        end
        
        if json["enlargement"]
          @enlargement = NPR::Entity::Enlargement.new(json["enlargement"])
        end
        
        if json["provider"]
          @provider = NPR::Entity::Provider.new(json["provider"])
        end
        
        extract_shallow_attributes(json)
        create_relations(json)
      end
    end # Image
  end # Entity
end # NPR

##
# NPR::Entity::Audio
#
module NPR
  module Entity
    class Audio < Base
      attr_accessor :id, :type, :permissions, :stream, :formats
      shallow_attribute "title", "duration", "description", "rightsHolder"
      
      #-------------------
      # +stream+ returns true if "active" is set to "true"
      # 
      def initialize(json)
        @id   = json["id"].to_i
        @type = json["type"]
        
        if json["permissions"]
          @permissions = NPR::Entity::Permissions.new(json["permissions"])
        end
        
        if json["stream"]
          @stream = json["stream"]["active"] == "true"
        end
        
        if json["format"]
          @formats = NPR::Entity::Formats.new(json["format"])
        end
        
        extract_shallow_attributes(json)
      end
    end # Audio
  end # Entity
end # NPR

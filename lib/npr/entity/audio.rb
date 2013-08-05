##
# NPR::Entity::Audio
#
module NPR
  module Entity
    class Audio < Base
      attr_accessor :id, :type
      shallow_attribute "title", "duration", "description", "rightsHolder"
      has_one "permissions", :class_name => NPR::Entity::Permissions
      has_one "formats", :key => "format", :class_name => NPR::Entity::Formats
      has_one "stream", :class_name => NPR::Entity::Stream

      #-------------------

      def initialize(json)
        @id   = json["id"].to_i
        @type = json["type"]

        create_relations(json)
        extract_shallow_attributes(json)
      end
    end # Audio
  end # Entity
end # NPR

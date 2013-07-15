##
# NPR::Entity::Formats
#
# Audio Formats
module NPR
  module Entity
    class Formats < Base
      has_many "mp3s", :key => "mp3", :class_name => NPR::Entity::MP3
      shallow_attribute "wm", "rm", "mediastream"

      #--------------------

      def initialize(json)
        extract_shallow_attributes(json)
        create_relations(json)
      end
    end # Formats
  end # Entity
end # NPR

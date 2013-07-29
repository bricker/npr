##
# NPR::Entity::Permissions
#
# Audio permissions
#
module NPR
  module Entity
    class Permissions < Base
      attr_accessor :download, :stream, :embed

      def initialize(json)
        @download = json["download"]["allow"] == "true" if json["download"]
        @stream   = json["stream"]["allow"]   == "true" if json["stream"]
        @embed    = json["embed"]["allow"]    == "true" if json["embed"]
      end


      def download?
        !!@download
      end

      def stream?
        !!@stream
      end

      def embed?
        !!@embed
      end
    end
  end
end

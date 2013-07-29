##
# NPR::Entity::ExternalAsset
#
# Audio permissions
#
module NPR
  module Entity
    class ExternalAsset < Base
      attr_accessor :id, :type

      shallow_attribute \
        "url",
        "oEmbed",
        "externalId",
        "credit",
        "parameters",
        "caption"

      def initialize(json)
        @id   = json["id"].to_i
        @type = json["type"]

        extract_shallow_attributes(json)
      end
    end
  end
end

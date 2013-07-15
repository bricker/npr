##
# NPR::Entity::PromoArtBookEdition
#
module NPR
  module Entity
    class PromoArtBookEdition < Base
      attr_accessor :refId, :num

      #-------------------

      def initialize(json)
        @refId = json["refId"].to_i
        @num   = json["num"].to_i
      end
    end # PromoArtBookEdition
  end # Entity
end # NPR

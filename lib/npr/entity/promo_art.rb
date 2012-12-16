##
# NPR::Entity::PromoArt
#
module NPR
  module Entity
    class PromoArt < Image
      attr_accessor :bookEditionId
      
      #--------------------
      
      def initialize(json)
        @bookEditionId = json["bookEditionId"].to_i
        super
      end
    end # PromoArt
  end # Entity
end # NPR

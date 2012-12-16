##
# NPR::Entity::PromoArt
#
module NPR
  module Entity
    class PromoArt < Base
      attr_accessor :refId, :num
      
      #-------------------
      
      def initialize(json)
        @refId = json["refId"].to_i
        @num   = json["num"].to_i
      end
    end # PromoArt
  end # Entity
end # NPR

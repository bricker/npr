##
# NPR::Entity::MemberPromoArt
#
module NPR
  module Entity
    class MemberPromoArt < Base
      attr_accessor :refId, :num

      #-------------------

      def initialize(json)
        @refId = json["refId"].to_i
        @num   = json["num"].to_i
      end
    end # MemberPromoArt
  end # Entity
end # NPR

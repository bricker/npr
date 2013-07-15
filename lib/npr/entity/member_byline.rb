##
# NPR::Entity::MemberByline
#
module NPR
  module Entity
    class MemberByline < Base
      attr_accessor :refId, :num

      #-------------------

      def initialize(json)
        @refId = json["refId"].to_i
        @num   = json["num"].to_i
      end
    end # MemberByline
  end # Entity
end # NPR

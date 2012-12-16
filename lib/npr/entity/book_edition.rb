##
# NPR::Entity::BookEdition
#
module NPR
  module Entity
    class BookEdition < Base
      attr_accessor :refId, :num
      
      #-------------------
      
      def initialize(json)
        @refId = json["refId"].to_i
        @num   = json["num"].to_i
      end
    end # BookEdition
  end # Entity
end # NPR
    
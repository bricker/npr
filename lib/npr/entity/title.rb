##
# NPR::Entity::Title
#
module NPR
  module Entity
    class Title < Base
      attr_accessor :num, :content

      def initialize(json)
        @num     = json["num"].to_i
        @content = json["$text"]
      end

      #--------------------

      def to_s
        @content.to_s
      end
    end # Title
  end # Entity
end # NPR

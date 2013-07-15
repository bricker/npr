##
# NPR::Entity::Program
#
module NPR
  module Entity
    class Program < Base
      attr_accessor :id, :code, :content

      #-------------------

      def initialize(json)
        @id      = json["id"].to_i
        @content = json["$text"]
        @code    = json["code"]
      end

      #-------------------

      def title
        @content.to_s
      end

      alias_method :to_s, :title
    end # Program
  end # Entity
end # NPR

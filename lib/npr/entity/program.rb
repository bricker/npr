##
# NPR::Entity::Program
#
module NPR
  module Entity
    class Program < Base
      attr_accessor :id, :code, :content

      #---------------------
    
      def initialize(json)
        @id      = json["id"].to_i
        @content = json["$text"]
        @code    = json["code"]
      end

      #---------------------
    
      def to_s
        @content.to_s
      end
    end # Program
  end # Entity
end # NPR

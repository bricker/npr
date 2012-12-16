##
# NPR::Entity::IntroText
#
module NPR
  module Entity
    class IntroText < Base
      attr_accessor :num, :content
      
      def initialize(json)
        @num     = json["num"].to_i
        @content = json["$text"] 
      end
      
      #--------------------
      
      def to_s
        @content
      end
    end # IntroText
  end # Entity
end # NPR

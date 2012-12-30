##
# NPR::Entity::Provider
#
module NPR
  module Entity
    class Provider < Base      
      attr_accessor :content, :url

      #----------------
      
      def initialize(json)
        @content = json["$text"]
        @url     = json["url"]
      end
      
      #----------------
      
      def to_s
        @content.to_s
      end
    end # Provider
  end # Entity
end # NPR

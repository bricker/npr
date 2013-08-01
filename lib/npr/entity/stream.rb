##
# NPR::Entity::Stream
module NPR
  module Entity
    class Stream < Base
      attr_accessor :active
      alias_method :active?, :active

      #-------------------

      def initialize(json)
        @active = json["active"] == "true"
      end
    end # Name
  end # Entity
end # NPR

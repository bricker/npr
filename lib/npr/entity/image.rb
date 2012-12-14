##
# NPR::Entity::Image
#
module NPR
  module Entity
    class Image < Base
      attr_accessor :caption, :link, :producer, :provider, :copyright
    
      def initialize(attributes={})
        @attributes = attributes
      end
    end # Image
  end # Entity
end # NPR

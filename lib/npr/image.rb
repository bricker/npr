##
# NPR::Image
#
module NPR
  class Image < Base
    attr_accessor :caption, :link, :producer, :provider, :copyright
    
    def initialize(attributes={})
      @attributes = attributes
    end
  end # Image
end # NPR

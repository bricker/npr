##
# NPR::Image
#
module NPR
  class Image
    def initialize(attributes={})
      @attributes = attributes
    end
    
    def method_missing(method, *args, &block)
      @attributes[method] || super
    end
  end # Image
end # NPR

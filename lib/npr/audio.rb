##
# NPR::Audio
#
module NPR
  class Audio
    def initialize(attributes={})
      @attributes = attributes
    end
    
    def method_missing(method, *args, &block)
      @attributes[method] || super
    end
  end # Audio
end # NPR

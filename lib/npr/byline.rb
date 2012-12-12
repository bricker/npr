##
# NPR::Byline
#
module NPR
  class Byline
    def initialize(attributes={})
      @attributes = attributes
    end
    
    def method_missing(method, *args, &block)
      @attributes[method] || super
    end
  end # Byline
end # NPR

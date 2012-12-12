##
# NPR::List
#
module NPR
  class List
    def initialize(attributes={})
      @attributes = attributes
    end
    
    def method_missing(method, *args, &block)
      @attributes[method] || super
    end
  end # List
end # NPR

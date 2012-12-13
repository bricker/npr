##
# NPR::Audio
#
module NPR
  class Audio
    attr_accessor :duration, :description, :format
    
    def initialize(attributes={})
      @attributes = attributes
    end
  end # Audio
end # NPR

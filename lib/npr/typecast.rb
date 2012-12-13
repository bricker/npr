##
# NPR::Typecast
#
# Helps with typecasting attributes
#
module NPR
  module Typecast
    #------------------
    # Define how to typecast an object
    CASTERS = {
      Fixnum => lambda { |a| a.to_i },
      Time   => lambda { |a| Time.parse(a) }
    }
    
    private
    
    #-------------------------
    # Turn the attribute into the specified type
    #
    # Example:
    #
    #   typecast_attribute("20", Fixnum) #=> 20
    #
    def typecast(value, type)
      CASTERS[type].call(value)
    end
  end
end

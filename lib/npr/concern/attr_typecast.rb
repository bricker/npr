require 'time'

##
# NPR::Concern::AttrTypecast
#
module NPR
  module Concern
    module AttrTypecast
      
      private
      
      #------------------
      
      def attr_typecast(key, value)
        if type = NPR::ATTR_TYPES[key]
          typecast(value, type)
        else
          value
        end
      end

      #------------------

      def typecast(value, klass)
        NPR::CASTERS[klass].call(value)
      end      
    end # AttrTypecast
  end # Concern
end # NPR

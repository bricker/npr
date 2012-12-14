require 'time'

##
# NPR::Concern::AttrTypecast
#
module NPR
  #------------------
  # Attributes that are being typecast to Ruby classes
  ATTR_TYPES = {
    "id"               => Fixnum,
    "partnerId"        => Fixnum,
    "storyDate"        => Time, 
    "pubDate"          => Time,
    "lastModifiedDate" => Time,
    "showDate"         => Time,
    "date"             => Time,
    "segNum"           => Fixnum
  }
  
  #------------------
  # How to typecast
  CASTERS = {
    Fixnum => lambda { |a| a.to_i },
    Time   => lambda { |a| !a.empty? ? Time.parse(a) : nil }
  }
  
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

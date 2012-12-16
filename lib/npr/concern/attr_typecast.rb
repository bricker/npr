require 'time'

##
# NPR::Concern::AttrTypecast
#
module NPR
  #------------------
  # Attributes that are being typecast to Ruby classes
  ATTR_TYPES = {
    "id"               => :string_to_i,
    "partnerId"        => :string_to_i,
    "storyDate"        => :string_time_parse, 
    "pubDate"          => :string_time_parse,
    "lastModifiedDate" => :string_time_parse,
    "showDate"         => :string_time_parse,
    "date"             => :string_time_parse,
    "segNum"           => :string_to_i,
    "num"              => :string_to_i,
    "timestamp"        => :string_time_at,
    "duration"         => :string_to_i
  }
  
  module Concern
    module AttrTypecast
      
      private
      
      #------------------
      # Typecasting methods
      def string_to_i(value)
        value.to_i
      end
      
      #------------------
      
      def string_time_parse(value)
        !value.empty? ? Time.parse(value) : nil
      end
      
      #------------------
      
      def string_time_at(value)
        Time.at(value.to_f)
      end
      
      
      #------------------
      #------------------
      
      def attr_typecast(key, value)
        if method = NPR::ATTR_TYPES[key]
          send method, value
        else
          value
        end
      end   
    end # AttrTypecast
  end # Concern
end # NPR

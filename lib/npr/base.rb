##
# NPR::Base
#
# Class for all NPR Objects to inherit from
#
module NPR
  class Base
    #-----------------

    class << self
      attr_writer :_shallow_attributes
      
      def _shallow_attributes
        @_shallow_attributes ||= []
      end
      
      #-----------------
      
      def shallow_attribute(*attrs)
        self._shallow_attributes.push *attrs
        attr_accessor *attrs
      end
    end
    
    #-----------------
    
    def initialize(json={})
      @_json = json
    end

    #-----------------
    
    private
    
    def extract_shallow_attributes(json)
      self.class._shallow_attributes.each do |key|
        if node = json[key]
          send "#{key}=", attr_typecast(key, node["$text"])
        end
      end
    end
    
    def attr_typecast(*); end
    
  end
end

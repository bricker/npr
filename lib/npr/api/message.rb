##
# NPR::API::Message
#
# If the API returns any messages, use this class
# to represent it.
#
module NPR
  module API
    class Message
      include NPR::Concern::ShallowAttributes
      
      attr_accessor :id, :level, :text, :timestamp
    
      #------------------
      # Attributes that don't have any nested information.
      # For these, we just look directly at the JSON for
      # "$text" and set the value to that
      shallow_attribute "text", "timestamp"

      #------------------
    
      def initialize(json)
        @id    = json["id"]
        @level = json["level"]
      
        # Setup the shallow attributes
        # Set them and typecast them if necessary
        extract_shallow_attributes(json)
      end

      #------------------
    
      def error?
        self.level == "error"
      end
    
      #------------------

      def warning?
        self.level == "warning"
      end
    end # Message
  end # API
end # NPR

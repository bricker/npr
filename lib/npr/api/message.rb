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

      attr_accessor :id, :level
      shallow_attribute "text", "timestamp"

      #------------------

      def initialize(json)
        @_json = json
        @id    = @_json["id"]
        @level = @_json["level"]

        extract_shallow_attributes(@_json)
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

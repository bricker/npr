##
# NPR::API::Response
#
# Wrapper around a Faraday response object
# Pass in the full response object from Faraday
#
module NPR
  module API
    class Response
      include NPR::Concern::Relation

      has_many "messages", :key => "message", :class_name => NPR::API::Message
      attr_reader :raw, :version, :messages, :list

      #--------------------------

      def initialize(response)
        create_relations(response)

        @_response = response
        @raw       = response.body
        @version = @raw["version"]

        if list = @raw["list"]
          @list = NPR::Entity::List.new(list)
        end

        Array.wrap(@raw["message"]).each do |message|
          @messages.push NPR::API::Message.new(message)
        end
      end
    end # Response
  end # API
end # NPR

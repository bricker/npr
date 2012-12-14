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
      
      def initialize(response)
        create_relations(response)
        @raw      = response
        @version  = response.body["version"]
        
        if response.body["list"]
          @list = NPR::Entity::List.new(response.body["list"])
        end
        
        Array.wrap(response.body["message"]).each do |message|
          @messages.push NPR::API::Message.new(message)
        end
      end
    end # Response
  end # API
end # NPR

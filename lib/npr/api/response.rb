##
# NPR::API::Response
#
# Pass in the full response from Faraday
#
module NPR
  module API
    class Response
      attr_reader :raw, :version, :messages, :list
      
      def initialize(response)
        @raw      = response
        @version  = response.body["version"]
        @list     = NPR::Entity::List.new(response.body["list"])
        
        messages = []
        Array.wrap(response.body["message"]).each do |message|
          messages.push NPR::API::Message.new(message)
        end
        
        @messages = messages
      end
    end # Response
  end # API
end # NPR

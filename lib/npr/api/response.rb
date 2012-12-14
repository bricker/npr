##
# NPR::API::Response
#
# Pass in the full response from Faraday
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
        @list     = NPR::Entity::List.new(response.body["list"])
        
        Array.wrap(response.body["message"]).each do |message|
          @messages.push NPR::API::Message.new(message)
        end
      end
    end # Response
  end # API
end # NPR

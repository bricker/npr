##
# NPR::API::Client
#
# Basic client for interacting with the NPR API.
#
# Options passed in when initializing the client will
# go out with every API request. You may also pass in
# options to +#query+ for a per-request basis.
#
# You can also set params via +client.params+
#
# Params should be passed in exactly as they will be sent 
# to the API. Example: "apiKey", not "api_key"
# See the API documentation for what those params are.
#
module NPR
  module API
    class Client
      attr_accessor :params, :url

      #-----------------
      # Argument is a hash of params to send to the API.
      # See <http://www.npr.org/api/inputReference.php> for
      # API documentation.
      #
      # Example:
      #
      #   NPR::Client.new(apiKey: "YOUR_API_KEY", sort: "date descending")
      #
      # Any parameters passed into this method will override the
      # global configuration.
      #
      def initialize(params={})
        @params = NPR.config.merge(params)
        @url    = @params.delete(:url) || NPR::Configuration::API_ROOT
        @apiKey = @params.delete(:apiKey)
      end

      #-----------------
      # Send a query to the NPR API.
      #
      # Accepts a hash of options which get passed
      # directly to the API.
      #
      # Any parameters passed directly into this method
      # will override both the global configuration,
      # as well as any parameters stored in this object's
      # @params.
      #
      # Example:
      #
      #   client.query(sort: "date descending", requiredAssets: "image")
      #
      # For now, this forced JSON output.
      # TODO: Support more formats
      #
      def query(params={})
        path = params.delete(:path) || NPR::Configuration::API_QUERY_PATH
      
        response = connection.get do |request|
          request.url path
          request.headers['Content-Type'] = "application/json"

          request.params = @params.merge(params)
          request.params['output'] ||= "json"  # Only JSON is supported.
          request.params['apiKey'] ||= @apiKey
        end
        
        NPR::API::Response.new(response)
      end

      #-----------------
    
      private
    
      #-----------------
    
      def connection
        @connection ||= begin
          Faraday.new @url do |conn|
            conn.response :json
            conn.adapter Faraday.default_adapter
          end
        end
      end
    end # Client
  end # API
end # NPR

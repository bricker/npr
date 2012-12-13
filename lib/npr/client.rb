require 'faraday'
require 'faraday_middleware'

##
# NPR::Client
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
  class Client
    attr_accessor :params

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
      @params  = NPR.config.merge(params)
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
    def query(params={})
      if @apiKey.nil?
        raise NPR::NotConfiguredError, "apiKey must be set to perform a query"
      end
      
      response = connection.get do |request|
        request.url NPR::Configuration::API_QUERY_PATH
        request.params = @params.merge(params)
        request.params['apiKey'] = @apiKey
      end
      
      response.body
    end

    #-----------------
    
    private
    
    #-----------------
    
    def connection
      @connection ||= begin
        Faraday.new NPR::Configuration::API_ROOT do |conn|
          conn.response :xml, :content_type => /\bxml$/
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end # Client
end # NPR

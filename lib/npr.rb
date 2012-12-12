require "activesupport"

require "npr/version"
require "npr/config"
require "npr/errors"

module NPR
  #-------------------
  
  class << self
    attr_reader :config

    #-------------------
    # Pass a block to configure NPR globally.
    #
    # Options configured globally will be
    # passed in to every API request. They can
    # still be overridden on a per-query basis.
    #
    # Example:
    #
    #   NPR.configure do |config|
    #     config.apiKey         = "YOUR_API_KEY"
    #     config.sort           = "date descending"
    #     config.output         = "NPRML"
    #     config.requiredAssets = "text"
    #   end
    #
    def configure
      yield config
      config
    end
    
    #-------------------
    
    private

    #-------------------
    
    def config
      @config ||= NPR::Config.new
    end
  end
end # NPR

require "npr/story"
require "npr/image"
require "npr/audio"
require "npr/byline"

require "active_support/configurable"

##
# NPR::Configuration
#
module NPR  
  #-------------------
  # Pass a block to configure NPR client globally.
  #
  # Options configured globally will be
  # passed in to every API request. They can
  # still be overridden on a per-query or per-client
  # basis.
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
  # These two methods are basically just proxies to
  # NPR::Configuration, for simpler configuration
  #
  def self.configure
    yield @config ||= NPR::Configuration.new
  end

  #-------------------
  
  def self.config
    @config
  end
  
  #-------------------
  
  class Configuration
    include ActiveSupport::Configurable
    
    API_ROOT = "http://api.npr.org"
    
    API_QUERY_PATH = "/query"
    API_LIST_PATH  = "/list"
    
    # List all the parameters that the NPR API
    # can accept. Some are left out that don't 
    # make sense to globally configure (such as
    # +:id+, +:startNum+, and +:callback+)
    API_OPTIONS = [
      # List options
      :storyCountAll, 
      :storyCountMonth, 
      :storyCountToday,
      :childrenOf, 
      :hideChildren,
      
      # Story options
      :apiKey, 
      :orgId, 
      :meta, 
      :output, 
      :fields,
      :sort, 
      :numResults, 
      :action, 
      :requiredAssets,
      :date, 
      :startDate, 
      :endDate, 
      :dateType,
      :searchTerm, 
      :searchType, 
      :title
    ]
    
    config_accessor *API_OPTIONS
  end # Configuration
end # NPR

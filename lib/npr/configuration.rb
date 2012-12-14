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
  def self.configure
    yield config
  end

  #-------------------
  
  def self.config
    @config ||= NPR::Configuration.new
  end
  
  #-------------------
  # NPR::Configuration
  #
  # Probably doesn't need to be accessed directly.
  # You can get the global configuration for the NPR
  # gem by accessing +NPR.config+
  #
  class Configuration
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
    
    attr_accessor *API_OPTIONS

    #-------------------
    # You can pass in a hash of options to 
    # Configuration.new
    def initialize(options={})
      options.each do |key, value|
        send "#{key}=", value
      end
    end
    
    #-------------------
    # Convenience method
    def merge(hash)
      to_hash.merge hash
    end

    #-------------------
    # Convert this Configuration object into a Hash
    #
    # Why don't we inherit from OrderedOptions?
    #
    # Since the API options are out of our control
    # (without having to map every API option to 
    # internal methods), it is possible that one
    # of the config options will conflict with
    # something in Ruby. For example, the "sort"
    # option that the NPR API allows would mean
    # we'd have to overwrite Ruby's Hash#sort 
    # method.
    #
    # We *could* just map out config options to
    # the API options, but I think it's more
    # important to keep the gem config options
    # in perfect sync with the API options.
    #
    def to_hash
      hash = {}
      instance_variables.each do |var|
        hash[var[1..-1].to_sym] = instance_variable_get(var)
      end
      hash
    end
  end # Configuration
end # NPR

##
# NPR::Config
#
module NPR
  class Config
    API_ROOT = "http://api.npr.org"
    API_PATH = "/query"
    
    attr_accessor :apiKey
  end # Config
end # NPR

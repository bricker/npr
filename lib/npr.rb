##
# NPR
#
module NPR
  #------------------
  # Attributes that are being typecast to Ruby classes
  ATTR_TYPES = {
    "id"               => Fixnum,
    "partnerId"        => Fixnum,
    "storyDate"        => Time, 
    "pubDate"          => Time,
    "lastModifiedDate" => Time,
    "showDate"         => Time,
    "segNum"           => Fixnum
  }
  
  #------------------
  # How to typecast
  CASTERS = {
    Fixnum => lambda { |a| a.to_i },
    Time   => lambda { |a| Time.parse(a) }
  }
end

#------------------
# Dependencies
require 'faraday'
require 'faraday_middleware'
require "npr/core_ext/array/wrap"

#------------------
# Internal
require "npr/version"
require "npr/configuration"
require "npr/errors"
require "npr/concern"
require "npr/concern/attr_typecast"
require "npr/concern/shallow_attributes"
require "npr/concern/relation"

#------------------
# API handlers
require "npr/api"
require "npr/api/query_builder"
require "npr/api/client"
require "npr/api/message"
require "npr/api/response"

#------------------
# NPR Entities
require "npr/entity"
require "npr/entity/base"
require "npr/entity/link"
require "npr/entity/image"
require "npr/entity/audio"
require "npr/entity/byline"
require "npr/entity/pull_quote"
require "npr/entity/organization"
require "npr/entity/program"
require "npr/entity/show"
require "npr/entity/related_link"
require "npr/entity/paragraph"
require "npr/entity/story"
require "npr/entity/list"

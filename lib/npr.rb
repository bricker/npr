##
# NPR
#
module NPR
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
require "npr/concern/links_association"

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
require "npr/entity/paragraph"
require "npr/entity/organization"
require "npr/entity/transcript"
require "npr/entity/pull_quote"
require "npr/entity/related_link"
require "npr/entity/list_text"
require "npr/entity/author"
require "npr/entity/member_promo_art"
require "npr/entity/title"
require "npr/entity/intro_text"
require "npr/entity/member_byline"
require "npr/entity/promo_art_book_edition"
require "npr/entity/member"
require "npr/entity/parent"
require "npr/entity/collection"
require "npr/entity/provider"
require "npr/entity/enlargement"
require "npr/entity/crop"
require "npr/entity/image"
require "npr/entity/promo_art"
require "npr/entity/mp3"
require "npr/entity/formats"
require "npr/entity/permissions"
require "npr/entity/audio"
require "npr/entity/book"
require "npr/entity/book_edition"
require "npr/entity/name"
require "npr/entity/byline"
require "npr/entity/program"
require "npr/entity/show"
require "npr/entity/text"
require "npr/entity/story"
require "npr/entity/list"

##
# NPR::Entity::Story
#
module NPR
  module Entity
    class Story < Base
      #-------------------------
    
      class << self
        #-------------------------
        # Find a story based on ID
        # 
        # This method is meant to be a quick, easy
        # way to find a story just by its ID. 
        #
        # If you need more control over what gets
        # fetched and how, use NPR::Client directly,
        # or the other chainable methods (+where+,
        # +order+, etc.)
        #
        # It is not possible to pass options into this
        # method. Therefore, you *must* globally 
        # configure at least the apiKey using 
        # +NPR.configure+.
        #
        # Example:
        #
        #   NPR::Entity::Story.find(1000)
        #
        # TODO: API Error handling
        def find(id)
          response = query_by_id(id)
        
          if !response.messages.empty?
            response.messages
          else
            response.list.stories.first
          end
        end
        
        #-------------------------
        # Same as above, but returns +nil+ if a single story isn't
        # returned.
        #
        # Note that right now this method only checks if one story
        # was returned. If any more or less, then it assumes
        # there was a problem.
        #
        # TODO: Actually check the messages to handle the response
        # more accurately.
        def find_by_id(id)
          response = query_by_id(id)
        
          stories = response.list.stories
          if stories.size == 1
            stories.first
          else
            nil
          end
        end

        #-------------------------
        # For each class builder method defined in NPR::API::QueryBuilder,
        # define a method on this class which initializes a new
        # QueryBuilder and proxies to its corresponding method on
        # Query Builder class.
        #
        # We could use ActiveSupport's delegation for this, but 
        # this is simple enough.
        NPR::API::QueryBuilder::CLASS_BUILDER_METHODS.each do |method|
          define_method method do |args|
            NPR::API::QueryBuilder.new(self).send(method, args)
          end
        end
      
        #-------------------------
        
        private
      
        def query_by_id(id)
          client = NPR::API::Client.new(
            :apiKey => NPR.config.apiKey,
            :output => "json")

          client.query(:id => id)
        end
      end

      #-------------------------
      # Association accessors
    
      # Attributes that we are using as-is
      # Use strings so that we don't have to
      # convert between Strings and Symbols.
      ATTR_AS_IS = [
        "thumbnail", 
        "parent", 
        "container",
        "text", 
        "textWithHtml", 
      ]
      attr_accessor *ATTR_AS_IS
      attr_accessor :id
    
      #------------------
    
      has_many "images",        :key => "image",        :class_name => NPR::Entity::Image
      has_many "bylines",       :key => "byline",       :class_name => NPR::Entity::Image
      has_many "audio",         :key => "audio",        :class_name => NPR::Entity::Image
      has_many "organizations", :key => "organization", :class_name => NPR::Entity::Organization
      has_many "links",         :key => "link",         :class_name => NPR::Entity::Link
      has_many "related_links", :key => "relatedLink",  :class_name => NPR::Entity::RelatedLink
      has_many "pull_quotes",   :key => "pullQuote",    :class_name => NPR::Entity::PullQuote
    
      #------------------
    
      shallow_attribute(
        "title",
        "partnerId",
        "subtitle",
        "shortTitle",
        "teaser",
        "miniTeaser",
        "slug",
        "storyDate",
        "pubDate",
        "lastModifiedDate",
        "keywords",
        "priorityKeywords",
        "fullText"
      )
        
      #-------------------------
      # For now, "associations" are just arrays.
      # This will be replaced with a more "ActiveRecord" 
      # style behavior.
      def initialize(json)
        self.id = json["id"].to_i
      
        extract_shallow_attributes(json)
        create_relations(json)
      end
    
      #-------------------------
      # The primary image. Looks at the "type" attribute on 
      # an image and finds any with type "primary". If none
      # are found, then return the first image of any type.
      def primary_image
        @primary_image ||= begin
          primary = self.images.find { |i| i["type"] == "primary"}
          primary || self.images.first
        end
      end
    end # Story
  end # Entity
end # NPR

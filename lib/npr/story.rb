##
# NPR::Story
#
module NPR
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
      #   NPR::Story.find(1000)
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
      # For each class builder method defined in NPR::QueryBuilder,
      # define a method on this class which initializes a new
      # QueryBuilder and proxies to its corresponding method on
      # Query Builder class.
      #
      # We could use ActiveSupport's delegation for this, but 
      # this is simple enough.
      NPR::QueryBuilder::CLASS_BUILDER_METHODS.each do |method|
        define_method method do |args|
          NPR::QueryBuilder.new(self).send(method, args)
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

    #------------------
    # Relations
    # 
    # * The key is the relation name
    # * The value is an array of [JSON key, class]
    RELATIONS = {
      "images"        => ["image", NPR::Image],
      "bylines"       => ["byline", NPR::Byline],
      "audio"         => ["audio", NPR::Audio],
      "organizations" => ["organization", NPR::Organization],
      "links"         => ["link", NPR::Link],
      "related_links" => ["relatedLink", NPR::RelatedLink],
      "pull_quotes"   => ["pullQuote", NPR::PullQuote]
    }
    attr_accessor *RELATIONS.keys
    
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
    
    #------------------
    # Attributes that are being typecast to Ruby classes
    ATTR_TYPECAST = {
      "id"               => Fixnum,
      "partnerId"        => Fixnum,
      "storyDate"        => Time, 
      "pubDate"          => Time,
      "lastModifiedDate" => Time
    }
    attr_accessor *ATTR_TYPECAST.keys
    
    #-------------------------
    # For now, "associations" are just arrays.
    # This will be replaced with a more "ActiveRecord" 
    # style behavior.
    def initialize(json={})
      self.id = json["id"].to_i
      
      extract_shallow_attributes(json)

      # Setup associations
      RELATIONS.each do |name, info|
        key, klass = info
        collection = []
        
        Array.wrap(json[key]).each { |obj| collection << klass.new(obj) }
        send "#{name}=", collection
      end
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
    
    #-------------------------
    
    private
    
    def attr_typecast(key, value)
      if type = ATTR_TYPECAST[key]
        value.cast_to(type)
      else
        value
      end
    end
  end # Story
end # NPR

##
# NPR::Story
#
module NPR
  class Story
    include NPR::Typecast
    
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
      # TODO: API Error Handling
      # TODO: Accept multiple ID's
      #
      def find(id)
        client = NPR::Client.new(:apiKey => NPR.config.apiKey)
        response = client.query(:id => id)
        new(response["list"]["story"])
      end
    end

    #-------------------------
    # Association accessors
    # the :_attr methods are what was received
    # from the API. The normal :attr ones are
    # the actual association, which should be used
    # instead of the raw data
    attr_accessor :images, :audio, :bylines
    attr_accessor :_byline, :_image, :_audio
    
    # Attributes that we are using as-is
    # Use strings so that we don't have to
    # convert between Strings and Symbols.
    ATTR_AS_IS = [
      "title", 
      "subtitle", 
      "shortTitle",
      "teaser", 
      "miniTeaser", 
      "slug", 
      "thumbnail", 
      "keywords", 
      "priorityKeywords", 
      "parent", 
      "organization", 
      "link", 
      "container",
      "text", 
      "textWithHtml", 
      "fullText",
      "relatedLink", 
      "pullQuote"
    ]
    attr_accessor *ATTR_AS_IS

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
    def initialize(attributes={})
      @images     = []
      @audio      = []
      @bylines    = []
      
      # Special-case setters
      %w{ image byline audio }.each do |key|
        self.send "_#{key}=", attributes[key]
      end
      
      Array.wrap(self._image).each do |image|
        self.images.push NPR::Image.new(image)
      end
      
      Array.wrap(self._audio).each do |audio|
        self.audio.push NPR::Audio.new(audio)
      end
      
      Array.wrap(self._byline).each do |byline|
        self.bylines.push NPR::Byline.new(byline)
      end
      
      ATTR_TYPECAST.each do |key, type|
        attribute = attributes[key]
        self.send "#{key}=", typecast(attribute, type)
      end
      
      ATTR_AS_IS.each do |key|
        attribute = attributes[key]
        self.send "#{key}=", attribute
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
  end # Story
end # NPR

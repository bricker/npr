require "active_support/core_ext/array/wrap"

##
# NPR::Story
#
module NPR
  class Story
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
    
    attr_accessor :relatedLink, :pullQuote
    
    attr_accessor :parent, :organization
    
    attr_accessor :text, :textWithHtml, :fullText
    
    # Attribute accessors
    attr_accessor :id, :link, :title, :partnerId,
                  :subtitle, :shortTitle, :teaser,
                  :miniTeaser, :slug, :thumbnail,
                  :storyDate, :pubDate, :lastModifiedDate,
                  :keywords, :priorityKeywords, 
                  :container
    
    
    #-------------------------
    # For now, "associations" are just arrays.
    # This will be replaced with a more "ActiveRecord" 
    # style behavior.
    def initialize(attributes={})
      @images     = []
      @audio      = []
      @bylines    = []
      
      Array.wrap(attributes["image"]).each do |image|
        self.images.push NPR::Image.new(image)
      end
      
      Array.wrap(attributes["audio"]).each do |audio|
        self.audio.push NPR::Audio.new(audio)
      end
      
      Array.wrap(attributes["byline"]).each do |byline|
        self.bylines.push NPR::Byline.new(byline)
      end
      
      # Special-case setters
      %w{ image byline audio }.each do |assoc|
        self.send "_#{assoc}=", attributes.delete(assoc)
      end
      
      # Setters for all the normal attributes
      attributes.keys.each do |attrib|
        self.send "#{attrib}=", attributes.delete(attrib)
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

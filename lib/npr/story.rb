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
      # In order to use this, you must configure
      # the at least the apiKey using NPR.configure
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
    
    attr_accessor :images, :audio, :bylines
    attr_reader :attributes
    
    def initialize(attributes={})
      @attributes = attributes
      @images     = []
      @audio      = []
      @bylines    = []
      
      Array.wrap(@attributes["images"]).each do |image|
        self.images.push NPR::Image.new(image)
      end
      
      Array.wrap(@attributes["audio"]).each do |audio|
        self.audio.push NPR::Audio.new(audio)
      end
      
      Array.wrap(@attributes["byline"]).each do |byline|
        self.bylines.push NPR::Byline.new(byline)
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

    def method_missing(method, *args, &block)
      @attributes[method] || super
    end
  end # Story
end # NPR

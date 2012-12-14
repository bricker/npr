##
# NPR::Link
#
module NPR
  class Link < Base
    attr_reader :type, :content

    #---------------------
    
    def initialize(json={})
      @content = json["$type"]
      @type    = json["type"]
    end

    #---------------------
    
    def to_s
      @content
    end
  end
end

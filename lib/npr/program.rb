##
# NPR::Program
#
module NPR
  class Program < Base
    attr_reader :id, :code, :content

    #---------------------
    
    def initialize(json={})
      @content = json["$text"]
      @code    = json["code"]
      @content = json["content"]
    end

    #---------------------
    
    def to_s
      @content
    end
  end # Program
end # NPR

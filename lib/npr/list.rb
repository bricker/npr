##
# NPR::List
#
module NPR
  class List < Base
    #------------------
    # Relations
    # 
    # * The key is the relation name
    # * The value is an array of [JSON key, class]
    RELATIONS = {      
      "links"   => ["link", NPR::Link],
      "stories" => ["story", NPR::Story]
    }
    attr_accessor *RELATIONS.keys
    
    #------------------

    shallow_attribute(
      "title",
      "teaser",
      "miniTeaser"
    )

    #------------------
    
    def initialize(json={})
      extract_shallow_attributes(json)

      # Setup associations
      RELATIONS.each do |name, info|
        key, klass = info
        collection = []
        
        json[key].each { |obj| collection << klass.new(obj) }
        send "#{name}=", collection
      end
    end
  end # List
end # NPR

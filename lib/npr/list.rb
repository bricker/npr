##
# NPR::List
#
module NPR
  class List < Base
    #------------------

    has_many "links", :key => "link", :class_name => NPR::Link
    has_many "stories", :key => "story", :class_name => NPR::Story

    #------------------

    shallow_attribute(
      "title",
      "teaser",
      "miniTeaser"
    )

    #------------------
    
    def initialize(json)
      extract_shallow_attributes(json)
      create_relations(json)
    end
  end # List
end # NPR

module NPR
  module Concern
    module LinksAssociation
      def self.included(base)
        base.has_many "links", :key => "link", :class_name => NPR::Entity::Link
      end

      #-------------------------
      # Find links of the passed in type.
      #
      # Example:
      #
      #   story.link_for("html")    #=> http://npr.org/...
      #   story.link_for("nothing") #=> nil
      #
      # Returns an the content of that link if found,
      # or nil if not found.
      #
      def link_for(type)
        if link = self.links.find { |link| link.type == type }
          link.to_s
        end
      end
    end # LinkAssociation
  end # Concern
end # NPR

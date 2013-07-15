##
# NPR::Entity::PullQuote
#
module NPR
  module Entity
    class PullQuote < Base
      attr_accessor :id
      shallow_attribute "text", "person", "date"

      def initialize(json)
        extract_shallow_attributes(json)
        @id = json["id"].to_i
      end
    end # PullQuote
  end # Entity
end # NPR

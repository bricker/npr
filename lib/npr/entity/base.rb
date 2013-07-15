##
# NPR::Entity::Base
#
# Class for all NPR Objects to inherit from
#
module NPR
  module Entity
    class Base
      include NPR::Concern::Relation
      include NPR::Concern::ShallowAttributes

      #-----------------
      # Override this
      def initialize(json={})
        @_json = json
      end
    end # Base
  end # Entity
end # NPR

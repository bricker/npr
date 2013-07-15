##
# NPR::Entity::Show
#
module NPR
  module Entity
    class Show < Base
      attr_accessor :program
      shallow_attribute "showDate", "segNum"

      def initialize(json)
        extract_shallow_attributes(json)

        if program = json["program"]
          @program = NPR::Entity::Program.new(program)
        end
      end
    end # Show
  end # Entity
end # NPR

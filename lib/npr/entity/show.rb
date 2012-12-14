##
# NPR::Entity::Show
#
module NPR
  module Entity
    class Show < Base
      attr_accessor :program
      shallow_attribute "showDate", "segNum"
      
      def initialize(json)
        if program = json["program"]
          @program = NPR::Entity::Program.new(program)
        end
        
        extract_shallow_attributes(json)
      end
    end # Show
  end # Entity
end # NPR

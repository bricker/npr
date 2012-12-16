##
# NPR::Entity::Member
#
module NPR
  module Entity
    class Member < Base
      attr_accessor :id
      has_one "promoArt",    :class_name => NPR::Entity::MemberPromoArt
      has_one "title",       :class_name => NPR::Entity::Title
      has_one "author",      :class_name => NPR::Entity::Author
      has_one "bookEdition", :class_name => NPR::Entity::PromoArtBookEdition
      has_one "introText",   :class_name => NPR::Entity::IntroText
      has_one "byline",      :class_name => NPR::Entity::MemberByline

      #------------------
      
      def initialize(json)
        @id = json["id"].to_i
        create_relations(json)
      end
    end # Member
  end # Entity
end # NPR

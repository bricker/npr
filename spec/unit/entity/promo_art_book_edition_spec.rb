require "spec_helper"

describe NPR::Entity::PromoArtBookEdition do
  json_fixture do
    <<-JSON
      {
        "refId": "153611349",
        "num": "4"
      }
    JSON
  end
  
  before :each do
    @promo_art_book_edition = NPR::Entity::PromoArtBookEdition.new(@fixture)
  end
  
  it "sets attributes" do
    @promo_art_book_edition.refId.should eq 153611349
    @promo_art_book_edition.num.should eq 4
  end
end

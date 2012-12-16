require "spec_helper"

describe NPR::Entity::PromoArt do
  json_fixture do
    <<-JSON
      {
        "refId": "153611356",
        "num": "1"
      }
    JSON
  end
  
  before :each do
    @promo_art = NPR::Entity::PromoArt.new(@fixture)
  end
  
  it "sets attributes" do
    @promo_art.refId.should eq 153611356
    @promo_art.num.should eq 1
  end
end

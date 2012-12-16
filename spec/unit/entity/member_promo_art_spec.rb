require "spec_helper"

describe NPR::Entity::MemberPromoArt do
  json_fixture do
    <<-JSON
      {
        "refId": "153611356",
        "num": "1"
      }
    JSON
  end
  
  before :each do
    @member_promo_art = NPR::Entity::MemberPromoArt.new(@fixture)
  end
  
  it "sets attributes" do
    @member_promo_art.refId.should eq 153611356
    @member_promo_art.num.should eq 1
  end
end

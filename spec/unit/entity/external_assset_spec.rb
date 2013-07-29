require "spec_helper"

describe NPR::Entity::ExternalAsset do
  json_fixture do
    <<-JSON
    {
      "id": "206744041",
      "type": "Twitter",
      "url": {
        "$text": "https://twitter.com/danmericaCNN/statuses/361945098524717056"
      },
      "oEmbed": {
        "$text": "oembed-361945098524717056"
      },
      "externalId": {
        "$text": "361945098524717056"
      },
      "credit": {},
      "parameters": {},
      "caption": {}
    }
    JSON
  end

  # NOTE: I couldn't find an externalAsset in the API which actually
  # has "credit", "parameters", or "caption" filled in, and this node
  # isn't documented, so I kind of have no idea what they are.
  before :each do
    @external_asset = NPR::Entity::ExternalAsset.new(@fixture)
  end

  it "sets attributes" do
    @external_asset.id.should eq 206744041
    @external_asset.type.should eq "Twitter"
    @external_asset.url.should match /danmericaCNN/
    @external_asset.oEmbed.should eq "oembed-361945098524717056"
    @external_asset.externalId.should eq "361945098524717056"
  end
end

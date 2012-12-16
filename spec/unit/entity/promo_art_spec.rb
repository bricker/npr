require "spec_helper"

describe NPR::Entity::PromoArt do
  json_fixture do
    <<-JSON
      {
        "id": "153610419",
        "type": "standard",
        "width": "200",
        "src": "http://media.npr.org/assets/bakertaylor/covers/a/after-the-apocalypse/9781931520294_custom-14e34b3b9f4a523765c08be02c4e1530607aa0e0.jpg?s=12",
        "bookEditionId": "153610403",
        "hasBorder": "false",
        "title": {
          "$text": "After the Apocalypse"
        },
        "caption": {},
        "link": {
          "url": ""
        },
        "producer": {},
        "provider": {
          "url": ""
        },
        "copyright": {
          "$text": "2011"
        },
        "crop": [
          {
            "type": "custom",
            "src": "http://media.npr.org/assets/bakertaylor/covers/a/after-the-apocalypse/9781931520294_custom-14e34b3b9f4a523765c08be02c4e1530607aa0e0.jpg",
            "height": "600",
            "width": "388"
          }
        ]
      }
    JSON
  end
  
  before :each do
    @promo_art = NPR::Entity::PromoArt.new(@fixture)
  end  
end

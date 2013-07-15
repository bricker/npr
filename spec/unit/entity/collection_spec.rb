require "spec_helper"

describe NPR::Entity::Collection do
  json_fixture do
    <<-JSON
      {
        "type": "list",
        "displayType": "Book",
        "id": "166481178",
        "title": {
          "$text": "The Year's Best SF Crosses Galaxies And Genres"
        },
        "introText": {},
        "member": [
          {
            "refId": "166481250",
            "num": "1",
            "label": "none"
          },
          {
            "refId": "166481791",
            "num": "2",
            "label": "none"
          },
          {
            "refId": "166482564",
            "num": "3",
            "label": "none"
          }
        ]
      }
    JSON
  end

  before :each do
    @collection = NPR::Entity::Collection.new(@fixture)
  end

end

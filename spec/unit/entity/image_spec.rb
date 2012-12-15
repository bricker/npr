require "spec_helper"

describe NPR::Entity::Image do
  json_fixture do
    <<-JSON
      {
        "id": "167273389",
        "type": "standard",
        "width": "200",
        "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg?s=12",
        "hasBorder": "false",
        "title": {
          "$text": "Jason Moran chats with Geri Allen on stage."
        },
        "caption": {
          "$text": "Jason Moran chats with Geri Allen on stage."
        },
        "link": {
          "url": ""
        },
        "producer": {},
        "provider": {
          "url": "",
          "$text": "Brendan Hoffman for NPR"
        },
        "copyright": {},
        "enlargement": {
          "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
          "caption": {}
        },
        "crop": [
          {
            "type": "enlargement",
            "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
            "height": "2000",
            "width": "3000"
          },
          {
            "type": "slide",
            "src": "http://media.npr.org/assets/img/2012/12/14/121208bh0224-cb0bda2d8c5ec53151388f8a5faf3ddf12580434.jpg",
            "height": "2000",
            "width": "3000"
          }
        ]
      }
    JSON
  end
  
  it ""
end

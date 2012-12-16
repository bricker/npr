require "spec_helper"

describe NPR::Entity::BookEdition do
  json_fixture do
    <<-JSON
      {
        "id": "153611349",
        "isbn": {
          "$text": "9780316098120"
        },
        "book": {
          "id": "153611337",
          "title": {
            "$text": "2312"
          },
          "link": {
            "type": "short",
            "$text": "http://n.pr/LdlQZZ"
          }
        },
        "publisher": {
          "$text": "Orbit"
        },
        "format": {
          "$text": "1"
        },
        "pubDate": {
          "$text": "2012-05-22 00:00:00"
        },
        "pagination": {
          "$text": "561 pages"
        },
        "listPrice": {
          "$text": "$25.99"
        }
      }
    JSON
  end
  
  before :each do
    @book_edition = NPR::Entity::BookEdition.new(@fixture)
  end
  
  pending
end
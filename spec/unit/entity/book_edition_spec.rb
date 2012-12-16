require "spec_helper"

describe NPR::Entity::BookEdition do
  json_fixture do
    <<-JSON
      {
        "refId": "153611349",
        "num": "4"
      }
    JSON
  end
  
  before :each do
    @book_edition = NPR::Entity::BookEdition.new(@fixture)
  end
  
  it "sets attributes" do
    @book_edition.refId.should eq 153611349
    @book_edition.num.should eq 4
  end
end

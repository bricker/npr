require "spec_helper"

describe NPR::Entity::Book do
  json_fixture do
    <<-JSON
      {
        "id": "153611337",
        "title": {
          "$text": "2312"
        },
        "link": {
          "type": "short",
          "$text": "http://n.pr/LdlQZZ"
        }
      }
    JSON
  end

  before :each do
    @book = NPR::Entity::Book.new(@fixture)
  end

  it "sets up attributes" do
    @book.id.should eq 153611337
    @book.title.should eq "2312"
  end

  it "creates relations" do
    @book.link.should be_a NPR::Entity::Link
  end
end

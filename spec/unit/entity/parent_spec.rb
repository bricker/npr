require "spec_helper"

describe NPR::Entity::Parent do
  json_fixture do
    <<-JSON
      {
        "id": "166488606",
        "type": "author",
        "title": {
          "$text": "Richard K. Morgan"
        },
        "link": [
          {
            "type": "html",
            "$text": "http://www.npr.org/books/authors/166488606/richard-k-morgan?ft=3&f=166480907"
          },
          {
            "type": "api",
            "$text": "http://api.npr.org/query?id=166488606&apiKey=MDA1OTI3MjQ5MDEyODUwMTE2MzM1YzNmZA004"
          }
        ]
      }
    JSON
  end

  before :each do
    @parent = NPR::Entity::Parent.new(@fixture)
  end

  it "sets up attributes" do
    @parent.id.should be_a Integer
    @parent.type.should eq "author"
    @parent.title.should eq "Richard K. Morgan"
  end

  it "has links" do
    @parent.links.should_not be_empty
  end
end

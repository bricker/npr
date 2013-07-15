require "spec_helper"

describe NPR::Entity::Author do
  json_fixture do
    <<-JSON
      {
        "id": "139197905",
        "num": "3",
        "title": {
          "$text": "Kim Stanley Robinson"
        },
        "link": {
          "type": "api",
          "$text": "http://api.npr.org/query?id=139197905&apiKey=MDA1OTI3MjQ5MDEyODUwMTE2MzM1YzNmZA004"
        }
      }
    JSON
  end

  before :each do
    @author = NPR::Entity::Author.new(@fixture)
  end

  it "sets attributes" do
    @author.id.should eq 139197905
    @author.num.should eq 3
    @author.title.should match /Kim/
    @author.link.should be_a NPR::Entity::Link
  end
end

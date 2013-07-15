require "spec_helper"

describe NPR::Entity::ListText do
  json_fixture do
    <<-JSON
      {
        "id": "166558361",
        "tag": "p",
        "paragraph": [
          {
            "num": "1",
            "$text": "<em>Annalee Newitz writes about the intersection of science and culture.</em>"
          }
        ]
      }
    JSON
  end

  before :each do
    @list_text = NPR::Entity::ListText.new(@fixture)
  end

  it "sets up attributes" do
    @list_text.id.should eq 166558361
    @list_text.tag.should eq "p"
  end

  it "sets up relations" do
    @list_text.paragraphs.first.should be_a NPR::Entity::Paragraph
  end
end

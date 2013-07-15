require "spec_helper"

describe NPR::Entity::PullQuote do
  json_fixture do
    <<-JSON
      {
        "id": "162081891",
        "text": {
          "$text": "Unstructured time outdoors is becoming a thing of the past."
        },
        "person": {
          "$text": "Chelsea Benson"
        },
        "date": {}
      }
    JSON
  end

  before :each do
    @pull_quote = NPR::Entity::PullQuote.new(@fixture)
  end

  it "sets up attributes" do
    @pull_quote.id.should be_a Integer
    @pull_quote.text.should match /Unstructured/
    @pull_quote.person.should match /Chelsea/
    @pull_quote.date.should eq nil # no date information
  end
end

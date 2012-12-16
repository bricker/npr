require "spec_helper"

describe NPR::Entity::IntroText do
  json_fixture do
    <<-JSON
      {
        "num": "5",
        "$text": "<p>A sweeping space opera, <em>2312</em> is about what happens to humanity once we've truly conquered the solar system. Humans have colonized most of the planets and moons in our local volume of space, and it's the end of an interplanetary age of exploration. Political powers are consolidating their territories.</p>"
      }
    JSON
  end
  
  before :each do
    @intro_text = NPR::Entity::IntroText.new(@fixture)
  end
  
  it "sets attributes" do
    @intro_text.num.should eq 5
    @intro_text.content.should match /sweeping space opera/
  end
  
  it "uses @content for to_s" do
    @intro_text.to_s.should eq @intro_text.content
  end
end

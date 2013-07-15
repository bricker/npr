require "spec_helper"

describe NPR::Entity::Text do
  json_fixture do
    <<-JSON
      {
        "paragraph": [
          {
            "num": "1",
            "$text": "As occurs after seemingly every mass killing that involves firearms, the shootings in a suburban Denver movie theater last week have renewed calls for tougher gun control laws."
          },
          {
            "num": "2",
            "$text": "Just as predictably, those calls have led to pushback by gun-rights advocates who accuse those calling for stricter legislation of trying to exploit the tragedy to restrict Americans' Second Amendment rights."
          },
          {
            "num": "3",
            "$text": "Worth noting is that neither of the two major-party candidates running for the White House has engaged in any current gun control debate."
          },
          {
            "num": "4",
            "$text": "Why that should be is no mystery. For both President Obama, the Democratic standard-bearer, and Mitt Romney, the all-but-official Republican presidential nominee, there's little upside less than four months before Election Day to doing so."
          },
          {
            "num": "5",
            "$text": "Robert J. Spitzer, a political scientist at the State University of New York, Cortland, has written extensively on the nexus of gun control and politics as well as the American presidency. He explained in an interview with It's All Politics:"
          },
          {
            "num": "6"
          },
          {
            "num": "7",
            "$text": "First of all, the Democrats for several years have been backing away from the gun issue. There are always a few exceptions, [Rep.] Carolyn McCarthy [D-N.Y.], people like that. And even though in his background Obama supported stronger gun laws when he was in the Senate and in the state House in Illinois, he clearly made a decision comparable to his political party to sidestep the gun issue. He even signed into law two pro-gun measures - one to allow people to carry guns in national parks and another to allow guns onto Amtrak trains."
          }
        ]
      }
    JSON
  end

  before :each do
    @text = NPR::Entity::Text.new(@fixture)
  end

  it "has paragraphs" do
    @text.paragraphs.size.should eq 7
  end

  it "joins all paragraphs together with to_s" do
    s = @text.to_s
    s.should match /^As occurs/
    s.should match /Amtrak trains\.$/
    s.should match /\n/
  end

  it "wraps each paragraph in p tags for #to_html" do
    s = @text.to_html
    s.should match /\A\<p\>/
    s.should match /\<\/p\>\n\z/
    s.should match /^\<p\>/
    s.should match /\<\/p\>$/
  end
end

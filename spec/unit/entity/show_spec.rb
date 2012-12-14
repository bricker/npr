require "spec_helper"

describe NPR::Entity::Show do
  json_fixture do
    <<-JSON
      {
        "program": {
          "id": "3",
          "code": "ME",
          "$text": "Morning Edition"
        },
        "showDate": {
          "$text": "Wed, 12 Dec 2012 04:00:00 -0500"
        },
        "segNum": {
          "$text": "4"
        }
      }
    JSON
  end
  
  before :each do
    @show = NPR::Entity::Show.new(@fixture)
  end
  
  it "has a program" do
    @show.program.code.should eq "ME"
  end
  
  it "doesn't make a program if it's not present in the json" do
    other_fixture = @fixture.dup
    other_fixture.delete("program")
    show = NPR::Entity::Show.new(other_fixture)
    show.program.should eq nil
  end

  it "sets up attributes" do
    @show.showDate.should be_a Time
    @show.segNum.should be_a Integer
  end
end

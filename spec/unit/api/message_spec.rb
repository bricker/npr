require "spec_helper"

describe NPR::API::Message do
  describe "warning" do
    json_fixture do
      <<-JSON
        {
          "id": "203",
          "level": "warning",
          "text": {
            "$text": "Query parameter id='000' is invalid because it is not an integer and was ignored."
          },
          "timestamp": {
            "$text": "1355552691.56"
          }
        }
      JSON
    end
  
    before :each do
      @message = NPR::API::Message.new(@fixture)
    end
  
    it "sets level and id" do
      @message.id.should eq "203"
      @message.level.should eq "warning"
    end
  
    it "returns true for #warning?" do
      @message.warning?.should eq true
    end
    
    it "sets text" do
      @message.text.should match /^Query/
    end
    
    it "sets timestamp" do
      @message.timestamp.should be_a Time
    end
  end
  
  #---------------------------
  
  describe "error" do
    json_fixture do
      <<-JSON
        {
          "id": "310",
          "level": "error",
          "text": {
            "$text": "The API key passed in () was invalid or no API key was passed in.  Please register for a valid API key."
          },
          "timestamp": {
            "$text": "1355554389.89"
          }
        }
      JSON
    end
    
    before :each do
      @message = NPR::API::Message.new(@fixture)
    end
    
    it "is an error" do
      @message.error?.should eq true
    end
  end
end

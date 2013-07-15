require "spec_helper"

describe NPR::Entity::List do
  before :each do
    response = mock_response "json/01_story_full_media.json" do
      NPR::API::Client.new(:apiKey => "key").query(:id => 999)
    end

    @list = response.list
  end

  it "extracts the attributes" do
    @list.title.should match /NPR/
    @list.teaser.should match /NPR/
    @list.miniTeaser.should match /NPR/
  end

  it "sets up relations" do
    @list.links.size.should eq 2
    @list.stories.size.should eq 1
  end
end

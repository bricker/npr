require "spec_helper"

describe NPR::API::QueryBuilder do
  describe "#to_params" do
    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "turns the query builder in params that the API can understand" do
      @builder.where(:id => 5).order("date descending").limit(10).offset(100)
      @builder.to_params.should eq Hash[
        :id         => 5 ,
        :sort       => "date descending",
        :numResults => 10,
        :startNum   => 100
      ]
    end

    it "merges in @builder[:extra] last, which overrides anything" do
      @builder.set(:id => 5).where(:id => 10)
      @builder.to_params.should eq Hash[:id => 5]
    end

    it "doesn't create params if the value was not set" do
      @builder.where(:id => 5).to_params.keys.should eq [:id]
    end

    it "is an empty hash if no params are set" do
      @builder.to_params.should eq Hash.new
    end
  end

  #----------------------

  describe "#to_a" do
    config!(:apiKey => "key")

    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
      @builder.set(:apiKey => "key")
    end

    it "returns an array of stories if present" do
      @builder.where(:id => 5).order("date descending").limit(10).offset(100)

      stories = mock_response "json/06_story_multiple_ids.json" do
        @builder.to_a
      end

      stories.should be_a Array
      stories.should_not be_empty
      stories.first.should be_a NPR::Story
    end

    it "returns an empty array if no list or no stories were found" do
      @builder.where(:id => 5).order("date descending").limit(10).offset(100)

      stories = mock_response "json/05_no_api_key.json" do
        @builder.to_a
      end

      stories.should be_a Array
      stories.should be_empty
    end
  end

  #----------------------

  describe "#query" do
    config!(:apiKey => "key")

    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "sends off a query and returns the response object" do
      response = mock_response "json/01_story_full_media.json" do
        @builder.where(:id => 100).query
      end

      response.should be_a NPR::API::Response
    end
  end

  #----------------------

  describe "#set" do
    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "sets arbitrary parameters" do
      @builder.set(:whatever => "something cool")
      @builder.builder[:extra].should eq Hash[
        :whatever => "something cool"
      ]
    end

    it "returns itself" do
      @builder.set(:a => "b").should eq @builder
    end
  end

  #----------------------

  describe "#where" do
    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "adds the conditions to the query builder" do
      @builder.where(:id => 9999)
      @builder.where(:origId => 100)

      @builder.builder.should eq Hash[
        :conditions => {
          :id     => 9999,
          :origId => 100
        }]
    end

    it "returns itself" do
      @builder.where(:id => 0).should eq @builder
    end
  end

  #----------------------

  describe "#order" do
    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "adds the order to the query builder" do
      @builder.order("date descending")
      @builder.builder.should eq Hash[:order => "date descending"]
    end

    it "returns itself" do
      @builder.order("date ascending").should eq @builder
    end
  end

  #----------------------

  describe "#limit" do
    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "adds the limit to the query builder" do
      @builder.limit(10)
      @builder.builder.should eq Hash[:limit => 10]
    end

    it "returns itself" do
      @builder.limit(0).should eq @builder
    end
  end

  #----------------------

  describe "#offset" do
    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "adds the offset to the query builder" do
      @builder.offset(100)
      @builder.builder.should eq Hash[:offset => 100]
    end

    it "returns itself" do
      @builder.offset(0).should eq @builder
    end
  end

  #----------------------

  describe "chaining queries" do
    before :each do
      @builder = NPR::API::QueryBuilder.new(NPR::Story)
    end

    it "can chain the queries" do
      @builder.where(:id => 5).order("date descending").limit(10).offset(100)
      @builder.builder.should eq Hash[
        :conditions => { :id => 5 },
        :order      => "date descending",
        :limit      => 10,
        :offset     => 100
      ]
    end
  end
end

##
# FixtureHelper
#
# Helps with doing inline fixtures for JSON strings
#
module FixtureHelper
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def json_fixture(&block)
      before :all do
        @json = yield
        @fixture = JSON.parse(@json)
      end

      after :all do
        @json, @fixture = nil, nil
      end
    end
  end
end

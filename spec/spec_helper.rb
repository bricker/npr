require 'bundler/setup'
Bundler.require

SPEC_ROOT    = File.dirname(__FILE__)
FIXTURE_ROOT = File.join SPEC_ROOT, "fixtures"

# Require the support files
Dir["#{SPEC_ROOT}/support/**/*.rb"].each { |f| require f }

# Disallow real network connections
require 'fakeweb'
FakeWeb.allow_net_connect = false

# Configuration
RSpec.configure do |config|
  config.include FakeResponse
  
  config.before do
    FakeWeb.clean_registry
  end
end

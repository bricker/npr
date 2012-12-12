require 'rubygems'
require 'bundler/setup'
Bundler.require

SPEC_ROOT = File.dirname(__FILE__)
Dir["#{SPEC_ROOT}/support/**/*.rb"].each { |f| require f }

require 'fakeweb'
FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.include RemoteStub
end

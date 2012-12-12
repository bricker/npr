require 'rubygems'
require 'bundler/setup'
Bundler.require

SPEC_ROOT = File.dirname(__FILE__)
Dir["#{SPEC_ROOT}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include RemoteStub
end

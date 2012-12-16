## !!Warning!!
#
# This spec makes __actual HTTP requests__ to the NPR API.
#
# It should be used sparingly as a functional test. It doesn't
# get run automatically with the rest of the specs.

require 'bundler/setup'
Bundler.require

describe "NPR API" do
  it "is true" do
    raise "false"
  end
end
# -*- encoding: utf-8 -*-
require File.expand_path('../lib/npr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryan Ricker"]
  gem.email         = ["bricker@scpr.org"]
  gem.description   = %q{A simple Ruby client for the NPR API}
  gem.summary       = %q{NPR API / Ruby}
  gem.homepage      = "http://github.com/bricker88/npr"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "npr"
  gem.require_paths = ["lib"]
  gem.version       = NPR::VERSION
end

# -*- encoding: utf-8 -*-
require File.expand_path('../lib/npr/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = "npr"
  s.version       = NPR::VERSION
  s.authors       = ["Bryan Ricker"]
  s.email         = ["bricker@scpr.org"]
  s.description   = "NPR (npr.org) is a news organization. " \
                    "This gem helps you pull NPR content with a nice Ruby DSL."
  s.summary       = %q{A Ruby client for the NPR API}
  s.homepage      = "http://github.com/bricker/npr"

  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f|
    File.basename(f)
  }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.licenses = ['MIT']

  s.add_dependency 'faraday', '~> 0.8.0'
  s.add_dependency 'faraday_middleware', '~> 0.9.0'

  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'fakeweb'
end

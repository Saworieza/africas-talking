# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'africas_talking/version'

Gem::Specification.new do |spec|
  spec.name          = "africas_talking"
  spec.version       = AfricasTalking::VERSION
  spec.authors       = ["Charles Chuck"]
  spec.email         = ["chalcchuck@gmail.com"]
  spec.summary       = %q{Africa's Talking ruby API wrapper.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://bitbucket.org/chalchuck/africas-talking"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "typhoeus"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end

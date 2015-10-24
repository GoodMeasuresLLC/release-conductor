# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'release-conductor/version'

Gem::Specification.new do |gem|
  gem.name          = "release-conductor"
  gem.version       = ReleaseConductor::VERSION
  gem.authors       = ["Rob Mathews"]
  gem.email         = ["rob.mathews@goodmeasures.com"]
  gem.description   = %q{Mark the phase of unfuddle tickets in staging and production during deployments}
  gem.summary       = %q{Mark the phase of unfuddle tickets in staging and production during deployments}
  gem.homepage      = "https://github.com/GoodMeasuresLLC/release-conductor"
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 2.0.0'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '>= 3.0.1'
  gem.add_dependency 'json'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'byebug'
end

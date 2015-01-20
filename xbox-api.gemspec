# -*- encoding: utf-8 -*-
require File.expand_path('../lib/xbox-api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Flores"]
  gem.email         = ["xboxapi@alexflor.es"]
  gem.description   = %q{An Xbox API wrapper that allows one to fetch profiles, games, achievements and friends data}
  gem.summary       = %q{A Ruby wrapper for the xboxapi.com API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "xbox-api"
  gem.require_paths = ["lib"]
  gem.version       = Xboxapi::Wrapper::VERSION

  gem.add_runtime_dependency("faraday")
  gem.add_runtime_dependency("multi_json")
  gem.add_development_dependency("rspec")
end

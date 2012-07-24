# -*- encoding: utf-8 -*-
require File.expand_path('../lib/open_lighting/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marshall Yount"]
  gem.email         = ["marshall@yountlabs.com"]
  gem.description   = %q{A ruby gem wrapper for the Open Lighting Architecture project}
  gem.summary       = %q{A ruby gem wrapper for the Open Lighting Architecture project}
  gem.homepage      = "https://github.com/marshally/open_lighting_rb"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "open_lighting"
  gem.require_paths = ["lib"]
  gem.version       = OpenLighting::VERSION

  gem.add_development_dependency 'rspec',       '~> 2.11.0'
  gem.add_development_dependency 'growl',       '~> 1.0.3'
  gem.add_development_dependency 'guard',       '~> 1.2.3'
  gem.add_development_dependency 'guard-rspec', '~> 1.2.0'
end

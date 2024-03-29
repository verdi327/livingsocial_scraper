# -*- encoding: utf-8 -*-
require File.expand_path('../lib/livingsocial/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["michael verdi"]
  gem.email         = ["michael.v.verdi@gmail.com"]
  gem.description   = %q{Wrapper for the Livingsocial deals}
  gem.summary       = %q{Wrapper for the Livingsocial deals}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "livingsocial"
  gem.require_paths = ["lib"]
  gem.version       = Livingsocial::VERSION

  gem.add_runtime_dependency('nokogiri')
  gem.add_development_dependency('rspec')
end

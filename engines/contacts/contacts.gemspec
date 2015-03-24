$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "contacts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "contacts"
  s.version     = Contacts::VERSION
  s.authors     = ["Melody Stephen-Hassard"]
  s.email       = ["mlynch6@hotmail.com"]
  s.homepage    = "http://www.stephen-hassard.com"
  s.summary     = "Contact features for DanceCRMs."
  s.description = "Contact features for DanceCRM."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
	s.add_dependency 'core', '~> 0.0.1'
	s.add_dependency 'validates_timeliness', '~> 3.0'
	s.add_dependency 'simple_form', '~> 3.1.0'
	s.add_dependency 'will_paginate', '~> 3.0.6'

  s.add_development_dependency "pg"
end

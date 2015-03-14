$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "core"
  s.version     = Core::VERSION
  s.authors     = ["Melody Stephen-Hassard"]
  s.email       = ["mlynch6@hotmail.com"]
  s.homepage    = "http://stephen-hassard.com"
  s.summary     = "Account & User models for authentication."
  s.description = "Handles authentication and authorization."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"
	s.add_dependency 'bcrypt', '~> 3.1.7'
	s.add_dependency 'warden', '~> 1.2.3'
	s.add_dependency 'simple_form', '~> 3.1.0'

  s.add_development_dependency "pg"
end

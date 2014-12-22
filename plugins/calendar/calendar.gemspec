$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "calendar/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "calendar"
  s.version     = Calendar::VERSION
  s.authors     = ["Justin Wallace"]
  s.email       = ["wallace4@mit.edu"]
  s.summary     = "Calendar for events"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.5"

  s.add_dependency "mysql2"
  
  s.add_dependency 'momentjs-rails'
  s.add_dependency 'fullcalendar-rails'
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "epsilon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "epsilon"
  s.version     = Epsilon::VERSION
  s.authors     = ["Justin Wallace"]
  s.email       = ["brochicken@mit.edu"]
  s.summary     = "Tools to assist the epsilon (House Stweard) with their job"
  s.description = "E Sheet, TBD"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.5"
  s.add_dependency "paper_trail" "~> 4.0.0"
  s.add_dependency "mysql2"
end

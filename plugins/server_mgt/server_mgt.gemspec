$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "server_mgt/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "server_mgt"
  s.version     = ServerMgt::VERSION
  s.authors     = ["Justin Wallace"]
  s.email       = ["wallace4@mit.edu"]
  s.summary     = "Web interface for server management."
  s.description = "Experimental"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.5"

  s.add_dependency "mysql2"
end

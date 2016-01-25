# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
DKESite::Application.initialize!

require File.expand_path('../../lib/patches/abstract_mysql2_adapter', __FILE__)
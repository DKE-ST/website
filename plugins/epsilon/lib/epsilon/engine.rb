module Epsilon
  class Engine < ::Rails::Engine
    isolate_namespace Epsilon
    
    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    
    config.to_prepare do
      Dir.glob(Epsilon::Engine.root + "app/*/epsilon/*_extension.rb").each do |c|
        require_dependency(c)
      end
    end
  
  end
end

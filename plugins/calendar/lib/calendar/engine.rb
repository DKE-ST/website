module Calendar
  class Engine < ::Rails::Engine
    isolate_namespace Calendar

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    config.to_prepare do
      Dir.glob(Epsilon::Engine.root + 'app/*/calendar/*_extension.rb').each do |c|
        require_dependency(c)
      end
    end

    initializer :append_migrations do | app |
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do | expanded_path |
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end

  end
end

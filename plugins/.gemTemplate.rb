#gemTemplate.rb

run "mv #{self.name}.gemspec gemspec.tmp" 
run "head gemspec.tmp -n -2 >> #{self.name}.gemspec"
run "echo '  s.add_dependency \"mysql2\"' >> #{self.name}.gemspec"
run "tail gemspec.tmp -n 1 >> #{self.name}.gemspec"
run "rm gemspec.tmp"

unless File.symlink?("../../app/assets/javascripts/#{self.name}")
  File.symlink("../../../plugins/#{self.name}/app/assets/javascripts/#{self.name}", "../../app/assets/javascripts/#{self.name}")
end
unless File.symlink?("../../app/assets/stylesheets/#{self.name}")
  File.symlink("../../../plugins/#{self.name}/app/assets/stylesheets/#{self.name}", "../../app/assets/stylesheets/#{self.name}")
end
unless File.symlink?("../../spec/plugins/#{self.name}")
  File.symlink("../../plugins/#{self.original_name}/spec", "../../spec/plugins/#{self.name}")
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end

inside("lib/#{self.name}") do
  run "tail -n 2 engine.rb >> end.rb"
  File.open("engine.rb", "r+") do | f |
    name = /module (.+)\n/.match(f.readline)[1]
    f.readline
    f.write("    isolate_namespace #{name}\n\n")
    f.write("    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end\n\n")
    f.write("    config.to_prepare do
      Dir.glob(#{name}::Engine.root + 'app/*/#{self.name}/*_extension.rb').each do |c|
        require_dependency(c)
      end
    end\n\n") 
    f.write("    initializer :append_migrations do | app |
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do | expanded_path |
          app.config.paths['db/migrate'] << expanded_path
        end
      end
    end\n\n")
  end
  run "cat end.rb >> engine.rb"
  run "rm end.rb"
end

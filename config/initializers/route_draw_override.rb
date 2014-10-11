Rails::Application::RoutesReloader.class_eval do
  def load_paths
    paths.each { |path| load(path) }
    load(Rails.root.join('config','routes_public_pages.rb'))
  end
end
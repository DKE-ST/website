Rails::Application::RoutesReloader.class_eval do
  def load_paths
    paths.each { |path| load(path) }
    
    ####### Loads Chapter Public controller to root at very end ########
    Rails.application.routes.draw do 
      scope module: 'chapter' do
        match '/contact', to: 'public_pages#contact' , via: :get
        resources :public_pages, path: '/'
      end
    end
  end
end
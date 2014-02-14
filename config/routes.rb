RailsSite::Application.routes.draw do 
  
  #Home Page
  root 'chapter_public#home'
  
  ###STATIC PAGE CONTROLLER###
  #Used for pages in lambda
  match '/php_header', to: 'static_pages#php_header', via: :get
  #Used for authenticating users
  match '/login' , to: 'static_pages#home' , via: :post
  match '/success' , to: 'static_pages#success' , via: :get
  match '/loggedout' , to: 'static_pages#loggedout' , via: :get
  #Brochicken Settings Menu
  match '/settings', to: 'static_pages#settings', via: :get
  match '/settings', to: 'static_pages#update_settings', via: :patch
  
  
  match '/about', to: 'chapter_public#about' , via: :get
  match '/letter', to: 'chapter_public#president_letter' , via: :get
  match '/contact', to: 'chapter_public#contact' , via: :get
  match '/summer_housing', to: 'chapter_public#summer_app' , via: :get
  match '/summer_housing', to: 'chapter_public#submit_app' , via: :post
  resources :chapter_public, :path => '/summer'
  
  resources :house_rooms, :path => '/house'
  
  match '/profile', to: 'brothers#profile' , via: :get
  resources :brothers
  
  match '/add_pledges', to: 'users#add_pledges' , via: [:get, :post]
  match '/ch_pwd' , to: 'users#ch_pwd' , via: :get
  match '/ch_pwd' , to: 'users#update_pwd' , via: :patch
  resources :users
  
  match '/points/:id/new/:uname', to: 'house_points#new', via: :get
  match '/points/:id/new/', to: 'house_points#new', via: :get
  resources :house_points, :path => '/points'
  
  match '/epsilon/new_meal' , to: 'epsilon#new_meal' , via: :get
  match '/e_sheet' , to: 'epsilon#e_sheet' , via: :get
  match '/e_sheet' , to: 'epsilon#sign_up' , via: :patch
  match '/meal_plan' , to: 'epsilon#meal_plan' , via: :get
  match '/meal_plan' , to: 'epsilon#meal_plan_update' , via: :patch
  match '/wsty' , to: 'epsilon#dan' , via: :get
  resources :epsilon
  
  #Positions controller
  match 'positions/updatem' , to: 'positions#mass_edit', via: :get
  match 'positions/updatem' , to: 'positions#mass_update', via: :post
  resources :positions
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

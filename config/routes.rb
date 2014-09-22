DKESite::Application.routes.draw do
  #Home Page
  root 'chapter/public_pages#home'
  
  #Used for authenticating users
  match '/login' , to: 'chapter/public_pages#home' , via: :post
  match '/success' , to: 'application#success' , via: :get
  match '/loggedout' , to: 'application#loggedout' , via: :get
  
  #User Management Paths
  scope '/users' do
    match '/add_pledges' , to: 'users#add_pledges' , via: :get
    match '/add_pledges' , to: 'users#create_pledges' , via: :post
    match '/query' , to: 'users#query' , via: :post
    match '/kerberos', to: 'users#kerberos' , via: :post
    match '/filter', to: 'users#filter' , via: :post
  end
  resources :users
  
  scope module: 'chapter' do
    resources :brothers
    
    match '/house', to: 'residences#house', via: :get
    match '/tour', to: 'residences#tour', via: :get
    resources :residences
    
    scope '/officers'  do
      match '/mass_update', to: 'officers#mass_edit', via: :get
      match '/mass_update', to: 'officers#mass_update', via: :post
      match '/update_contacts', to: 'officers#update_contacts', via: :post
    end
    resources :officers
    
    match '/contact', to: 'public_pages#contact' , via: :get
    resources :public_pages, path: '/'
  end
  
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

Rails.application.routes.draw do
  
  scope module: 'chapter' do
    match '/contact', to: 'public_pages#contact' , via: :get
    resources :public_pages, path: '/'
  end
end
Rails.application.routes.draw do

  scope module: 'survey_poll' do
        
    resources :surveys, only: [:show, :index, :update]
    match '/results/:id/user/:uid', to: 'results#show_user', via: :get, as: :result_user
    resources :results, only: [:show, :index]
    
  end  
#  resources :officers do
#    resources :house_points, shallow: true
#  end
end

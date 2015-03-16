Rails.application.routes.draw do

  scope module: 'survey_poll' do
        
    resources :surveys
    resources :results
    
  end  
#  resources :officers do
#    resources :house_points, shallow: true
#  end
end

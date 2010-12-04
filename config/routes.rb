Failurous::Application.routes.draw do
  root :to => "home#index"

  match '/random_slogan' => "home#random_slogan"

  devise_for :users
  resource :sprockets
  resources :projects
  
  resources :fails do
    resources :occurences
    
     member do
       post :resolve
     end
  end
  
  resource :radiator
    
end


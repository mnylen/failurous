Failurous::Application.routes.draw do
  root :to => "home#index"
  
  devise_for :users
  resource :sprockets
  
  resources :projects do
    resources :fails
  end
    
end


Failurous::Application.routes.draw do
  get "projects/index"

  devise_for :users
  resource :sprockets
  
  resources :projects
  
end


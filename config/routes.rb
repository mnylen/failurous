Failurous::Application.routes.draw do
  devise_for :users
  resource :sprockets
end

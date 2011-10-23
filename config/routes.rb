Failurous::Application.routes.draw do
  namespace :api do
    resources :fails, :only => [:create]
  end
end

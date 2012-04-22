Locomotive::Application.routes.draw do
  resources :posts

  devise_for :users

  root :to => 'home#index'
end

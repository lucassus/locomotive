Locomotive::Application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :posts
    root :to => 'dashboard#index'
  end

  root :to => 'home#index'
end

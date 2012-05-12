Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resources :subscriptions, :only => [:index, :new, :create]

  root :to => 'home#index'
end

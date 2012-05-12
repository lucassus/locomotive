Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resources :subscriptions, :only => [:index, :edit, :new, :create]
  resources :billing_info, :only => [:edit, :create]

  root :to => 'home#index'
end

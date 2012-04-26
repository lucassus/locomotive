Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resource :user_searches, :only => [:show, :new, :create, :destroy]
  resources :encounters, :only => [:new, :create]

  root :to => 'home#index'
end

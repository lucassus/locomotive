Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resource :user_searches, :only => [:show, :new, :create, :destroy]

  root :to => 'home#index'
end

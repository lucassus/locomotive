Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resource :user_searches

  root :to => 'home#index'
end

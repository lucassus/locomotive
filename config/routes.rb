Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  root :to => 'home#index'
end

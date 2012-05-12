Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resources :subscriptions, :only => [:index, :edit, :new, :create]
  resource :billing_info, :only => [:edit, :create], :controller => :billing_info

  root :to => 'home#index'
end

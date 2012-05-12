Locomotive::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resources :subscriptions, :only => [:index, :edit, :new, :create] do
    member do
      put :cancel
      put :reactivate
      put :terminate
    end
  end

  resource :billing_info, :only => [:edit, :create], :controller => :billing_info

  root :to => 'home#index'
end

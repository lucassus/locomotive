Locomotive::Application.routes.draw do
  scope '(:locale)', :locale => /en|pl/ do
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

    resources :posts, :only => [:index, :show]
    resources :static_pages, :only => [:show]

    root :to => 'home#index'
  end

  match 'dummy_error' => 'home#dummy_error' unless Rails.env.production?
end

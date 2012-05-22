Locomotive::Application.routes.draw do
  scope '(:locale)', :locale => /en|pl/ do
    ActiveAdmin.routes(self)

    match '/auth/:provider/callback' => 'user_accounts#create'
    devise_for :users, :controllers => { :registrations => 'registrations' }

    resources :user_accounts, :only => [:index, :create, :destroy]
    resources :posts, :only => [:index, :show]
    resources :static_pages, :only => [:show], :path => '/pages'

    root :to => 'home#index'
  end

  match 'dummy_error' => 'home#dummy_error' unless Rails.env.production?
end

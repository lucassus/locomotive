Locomotive::Application.routes.draw do
  scope '(:locale)', :locale => /en|pl/ do
    ActiveAdmin.routes(self)
    devise_for :users

    resources :posts, :only => [:index, :show]
    resources :static_pages, :only => [:show], :path => '/pages'

    root :to => 'home#index'
  end

  match 'dummy_error' => 'home#dummy_error' unless Rails.env.production?
end

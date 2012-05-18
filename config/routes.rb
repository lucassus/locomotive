Locomotive::Application.routes.draw do
  scope '(:locale)', :locale => /en|pl/ do
    ActiveAdmin.routes(self)
    devise_for :users

    resources :posts, :only => [:index, :show]

    root :to => 'home#index'
  end
end

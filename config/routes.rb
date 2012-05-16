Locomotive::Application.routes.draw do
  scope '(:locale)', :locale => /en|pl/ do
    ActiveAdmin.routes(self)
    devise_for :users

    root :to => 'home#index'
  end
end

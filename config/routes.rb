Locomotive::Application.routes.draw do
  scope '(:locale)', :locale => /en|pl/ do
    ActiveAdmin.routes(self)
    devise_for :users

    focused_controller_routes do
      resources :posts, :only => [:index, :show]
    end

    root :to => 'home#index'
  end
end

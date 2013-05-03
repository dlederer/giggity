Giggity3::Application.routes.draw do

  ActiveAdmin.routes(self)

  get "static_pages/about"
  get "static_pages/demo_convo"
  get "static_pages/demo_profile"
  devise_for :users, :controllers => {:confirmations => "confirmations"}

  
  authenticated :user do
    root :to => 'users#index'
  end
  root :to => "static_pages#index"
  
  resources :users do
    get 'search', :on => :collection
    resources :videos
    resources :songs
    resources :photos do
      put 'update_profile', on: :member
    end
    resources :posts
  end
  resources :gigs do
    resources :messages
    resource :review
  end  
  
  get "about" => "static_pages#about"
  get "demo_convo" => "static_pages#demo_convo"
  get "demo_profile" => "static_pages#demo_profile"
end
Giggity3::Application.routes.draw do
  
  resources :photos
  resources :songs
  resources :conversations


  get "static_pages/about"
  devise_for :users, :controllers => { :registrations => "registrations" }

  authenticated :user do
    root :to => 'home#index'
  end
  
  resources :users do
    get 'search', :on => :collection
    resources :videos
    resources :songs
    resources :posts
  end
  resources :gigs do
    resources :messages
    resource :review
  end
  resources :home
  
  root :to => "home#index"
  get "about" => "static_pages#about"
end
Rails.application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]

  resources :users

  root 'static_pages#home'


  match '/signin',  to: 'sessions#new', via: :get
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/signup', to: 'users#new', via: [:get]

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'


end

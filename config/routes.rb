Rails.application.routes.draw do

  resources :users

  root 'static_pages#home'

  match '/signup', to: 'users#new', via: [:get]

  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'


end

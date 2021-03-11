Rails.application.routes.draw do

  get 'notifications/index'
  get 'sessions/new'
  get 'magics/index'
  get 'yugiohs/index'
  get 'pokemons/index'
  get 'duelmasters/index'
  get 'duelmasters/new'
  get 'pages/index'
  root 'pages#index'


  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]


  devise_for :users
  resources :messages, :only => [:create]
  resources :chats, :only => [:create, :show, :index]

  get '/login', to: 'sessions#new'  
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :rooms
  resources :duelmasters
  resources :yugiohs
  resources :pokemons
  resources :magics
  resources :notifications, only: :index
end

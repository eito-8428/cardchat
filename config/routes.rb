Rails.application.routes.draw do
  get 'login', to: 'sessions#new'  
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'sessions/new'
  get 'magics/index'
  get 'yugiohs/index'
  get 'pokemons/index'
  get 'duelmasters/index'
  get 'users/new'
  get 'pages/index'
  root 'pages#index'

  resources :users
  resources :rooms
end

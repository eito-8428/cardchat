Rails.application.routes.draw do
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

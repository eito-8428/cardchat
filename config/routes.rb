Rails.application.routes.draw do
  get 'rooms/show'
  root 'rooms#show'
end

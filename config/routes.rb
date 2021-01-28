Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  match '/users',   to: 'users#index',   via: 'get'

  resources :users, only: [:index, :show]
  resources :posts
end

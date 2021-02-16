Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  match '/friends', to: 'users#index', via: 'get'

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :update, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
end

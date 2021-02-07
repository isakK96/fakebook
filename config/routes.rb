Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users
  root 'posts#index'
  #match '/users', to: 'users#index', via: 'get'

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :update, :destroy]
  end
  resources :posts
  
end

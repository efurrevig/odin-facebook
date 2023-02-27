Rails.application.routes.draw do
  devise_for :users
  root "posts#index"

  resources :posts do
    resources :comments do
      resources :likes, only: [:create, :update, :destroy]
    end
    resources :likes, only: [:create, :update, :destroy]
  end

  resources :users do
    resources :friend_requests
    resources :friends
  end
  
  put '/users/:user_id/friend_requests/:id/edit', to: 'friend_requests#accept_friend_request', as: 'accept_friend_request'
  delete '/users/:user_id/friend_requests/:id/edit', to: 'friend_requests#decline_friend_request', as: 'decline_friend_request'
  put 'posts/:id/like', to: 'posts#like_post', as: 'like_post'
end

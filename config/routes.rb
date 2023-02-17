Rails.application.routes.draw do
  devise_for :users
  root "posts#index"

  resources :posts do
    resources :comments
    resources :likes
  end

  resources :users do
    resources :friend_requests
    resources :friends
  end
  
  put 'posts/:id/like', to: 'posts#like_post', as: 'like_post'
end

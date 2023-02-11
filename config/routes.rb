Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/update'
  get 'likes/destroy'
  get 'posts/index'
  get 'posts/create'
  devise_for :users
  root "posts#index"
  resources :posts do
    resources :comments
  end
end

Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/create'
  devise_for :users
  root "posts#index"
  resources :posts
end

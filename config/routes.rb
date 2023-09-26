Rails.application.routes.draw do
  get 'blogs/index'
  resources :blogs
  resources :dogs
  resources :perfumes
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]


  resources :dogs do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  root 'dogs#index'
end

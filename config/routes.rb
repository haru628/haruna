Rails.application.routes.draw do
  devise_for :users
  resources :blogs

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index,:show] # ユーザーマイページへのルーティング
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :relationships, only: [:create, :destroy]

  resources :talks do
    resources :likes, only: [:create, :destroy]
    
  end
  root 'talks#index'
end

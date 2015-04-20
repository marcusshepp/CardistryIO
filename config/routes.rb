Rails.application.routes.draw do
  resources :moves, only: [:index, :show, :new, :create]
  get "all_moves", to: "moves#all_moves"

  resources :users, only: [:show, :edit, :update]

  resources :videos, only: [:show, :new, :create]

  root to: "welcome#index"
end

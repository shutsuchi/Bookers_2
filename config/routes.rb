Rails.application.routes.draw do
  get 'home/about', to: 'home#about', as: 'home_about'
  devise_for :users

  root to: 'home#top'
  get 'search', to: 'searches#search', as: 'search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :index, :edit, :update] do
    get :following, :followers
  end
  resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
    resource :favorites, only: %i[ create destroy ]
    resource :book_comments, only: %i[ create destroy ]
  end
  resources :relationships, only: %i[ create destroy ]
end

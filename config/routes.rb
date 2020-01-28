Rails.application.routes.draw do
	get 'home/about', to: 'home#about', as: 'home_about'
  devise_for :users

	root to: 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :index, :edit, :update]
  resources :books, only: [:show, :index, :create, :edit, :update, :destroy]
end

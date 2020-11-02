Rails.application.routes.draw do
  root to: 'home#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/user_page',  to: 'home#index'
  get '/search', to: "api/rakuten#search"
  resources :users
  resources :books, only: [:show, :create]
end

Rails.application.routes.draw do
  root to: 'home#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/user/my_page',  to: 'home#index'
  post '/books/change_tag/:id',  to: 'books#change_tag'
  get '/search', to: "api/rakuten#search"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books, only: [:show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:index, :create, :destroy]
end

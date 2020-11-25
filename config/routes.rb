Rails.application.routes.draw do
  root to: 'home#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/users_page/:id',  to: 'home#index'
  get '/users_page',  to: 'home#index'
  get '/user/my_page',  to: 'home#index'
  post '/books/change_tag/:id',  to: 'books#change_tag'
  get '/get_search', to: "api/rakuten#search"
  get '/following',  to: 'home#index'
  get '/follower',  to: 'home#index'
  get '/search',  to: 'home#index'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :books, only: [:show, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:index, :create, :destroy]
  resources :impressions, only: [:index, :create, :show, :update, :destroy]
end

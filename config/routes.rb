Rails.application.routes.draw do
  root to: 'home#index'
  resources :users, only: [:index, :show, :new, :create, :update]
end

Rails.application.routes.draw do
  root "products#index"

  # Auth routes
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resource :cart, only: [:show]
  resources :cart_items, only: [:create]
  resources :orders, only: [:create, :show]
  resources :favorites, only: [:index, :create, :destroy]

   resources :categories, only: [:index, :show]
   resources :products, only: [:index, :show]

  namespace :api do
    namespace :v1 do
      resources :categories
      resources :products
      resources :users
      resources :orders, only: [:index, :show, :create]
    end
  end

  resources :categories, only: [:index, :show]

end
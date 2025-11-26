Rails.application.routes.draw do
  root "products#index"

  resource :cart, only: [:show] # Добавляем маршрут для корзины
  resources :cart_items, only: [:create]
  resources :orders, only: [:create, :show] # <-- Добавьте эту строку

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
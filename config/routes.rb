Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories
      resources :products
      resources :users
      resources :orders, only: [:index, :show, :create] 
    end
  end
end
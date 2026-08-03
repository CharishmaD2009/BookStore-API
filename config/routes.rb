Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do

      post "auth/register", to: "auth#register"
      post "auth/login",    to: "auth#login"
      post "auth/logout",   to: "auth#logout"

      get   "auth/me",      to: "auth#me"
      patch "auth/me",      to: "auth#update_profile"

      resources :books, only: [:index, :show]

      get    "cart",           to: "cart#show"
      post   "cart/items",     to: "cart#add_item"
      patch  "cart/items/:id", to: "cart#update_item"
      delete "cart/items/:id", to: "cart#remove_item"

      post   "orders",         to: "orders#create"
      get    "orders",         to: "orders#index"
      get    "orders/:id",     to: "orders#show"

      namespace :admin do
        resources :books, only: [:create, :update, :destroy]
        resources :orders, only: [:index, :update]
      end

    end
  end
end
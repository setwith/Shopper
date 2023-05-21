require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'search', to: 'search#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :products
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'

  # Defines the cart path route
  get 'cart', to: 'carts#show', as: :cart
  resources :line_items, only: %i[create destroy update]
  # post 'line_items/:id/increase_quantity', to: 'line_items#increase_quantity', as: 'line_item_increase'
  # post 'line_items/:id/decrease_quantity', to: 'line_items#decrease_quantity', as: 'line_item_decrease'
  resources :orders, only: %i[index create show destroy]
  patch 'orders/:id/update', to: 'orders#update', as: 'order_paid'
end

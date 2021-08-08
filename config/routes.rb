Rails.application.routes.draw do
  root 'packs#index'
  
  get 'orders/create'
  get 'orders/show'
  get 'carts/create'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  resources :packs, only: [:index, :show]
	resources :carts, only: [:index, :create, :destroy]
	resources :orders, only: [:create, :show, :index] do
    resources :payments, only: [:create]
  end
end
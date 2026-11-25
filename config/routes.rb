Rails.application.routes.draw do
  resources :orders, only: [:show]
  resources :products, only: [:show]

  devise_for :users
  get "checkout", to: "checkout#new", as: :checkout
  post "checkout", to: "checkout#create", as: :place_order
  get "cart", to: "cart#show", as: :cart
  post "cart/add/:product_id", to: "cart#add", as: :add_to_cart
  patch "cart/update/:product_id", to: "cart#update", as: :update_cart
  delete "cart/remove/:product_id", to: "cart#remove", as: :remove_from_cart
  get "store/index"
  root "store#index"
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

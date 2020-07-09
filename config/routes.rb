Rails.application.routes.draw do
  devise_for :users
  resources :products, except: :show
  root 'products#index'
  root to: "top#index"
end

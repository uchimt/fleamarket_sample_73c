Rails.application.routes.draw do
  root 'products#index'
  resources :products, except: :show
  get 'top/index'
end

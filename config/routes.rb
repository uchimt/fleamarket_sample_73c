Rails.application.routes.draw do
  resources :products, only: :new
  get 'top/index'
  root "top#index"
end

Rails.application.routes.draw do
  resources :products, only: [:new, :show]
  get 'top/index'
  root "top#index"
end

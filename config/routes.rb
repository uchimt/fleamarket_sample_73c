Rails.application.routes.draw do
  resources :products, only: [:new, :index]
  root to: "top#index"
end

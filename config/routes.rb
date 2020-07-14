Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'destinations', to: 'users/registrations#new_destination'
    post 'destinations', to: 'users/registrations#create_destination'
  end
  resources :products, only: [:new, :index, :show]
  root to: "top#index"
end

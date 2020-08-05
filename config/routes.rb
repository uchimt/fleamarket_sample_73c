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
  
  resources :products do
    #Ajaxで動くアクションルート作成
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'new_product_create'
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      #クレジットカード購入確認、購入時のアクション
      post 'purchase'
      get 'purchased'
      get 'buy'
  
    end
    resources :comments, only: :create
  end

  
  resources :cards, only: [:index, :new, :create, :destroy] 
    
  

  resources :top, only: [:index]
  root to: "top#index"

  root 'products#index'
  resources :products, except: :show
end

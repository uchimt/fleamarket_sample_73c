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
      get 'search'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' } 
    end
    member do
      get 'new_product_create'
      #クレジットカード購入確認、購入時のアクション
      post 'purchase'
      get 'purchased'
      get 'buy'
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :products do
    collection do
      match 'search' => 'products#search', via: [:get, :post]
    end
  end

  resources :categories, only: [:index, :show]

  resources :cards, only: [:index, :new, :create, :destroy]

  resources :users, only: :show do
    member do
      get 'on_display_products'
      get 'sold_products'
      get 'purchased_products'
      get 'logout_link'
    end
  end

  resources :cards, only: [:index, :new, :create, :destroy] 
 
  resources :top, only: [:index]
  root to: "top#index"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root 'homes#top'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  devise_scope :admin do
    delete "sign_out", to: "sessions#destroy"
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: "homes#top"
    get "homes/about", to: "homes#about"
    get '/search', to: 'searches#search', as: 'search'
    resources :chats, only: [:show, :create, :destroy]
    resource :map, only: [:show,:index]

    resources :posts, only: [:index, :show, :edit, :new, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      

    end

   
    
    resources :users do
      get 'unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
      patch 'withdraw', to: 'users#withdraw', as: 'withdraw'

      resource :relationships, only: [:create, :destroy]
      get "followings", to: "relationships#followings", as: "followings"
      get "followers", to: "relationships#followers", as: "followers"

      member do
        get :favorites
      end
    end
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

<<<<<<< HEAD
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
    resources :post_comments, only: [:index, :destroy]
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: "homes#top"
    get "homes/about" => "homes#about"
    get '/search', to: 'searches#search', as: 'search'

    resources :chats, only: [:show, :create, :destroy]
=======

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
>>>>>>> d052277aecb7edfa278b77ede3693369c521e190

    resources :posts, only: [:index, :show, :edit, :new, :create, :destroy, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
<<<<<<< HEAD
    end

    resources :users do
      get 'unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
      patch 'withdraw', to: 'users#withdraw', as: 'withdraw'

      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"

      member do
        get :favorites
      end
    end
  end
=======
      

    end

   
    
    resources :users do
      get 'unsubscribe', to: 'users#unsubscribe', as: 'unsubscribe'
      patch 'withdraw', to: 'users#withdraw', as: 'withdraw'
>>>>>>> d052277aecb7edfa278b77ede3693369c521e190

      resource :relationships, only: [:create, :destroy]
      get "followings", to: "relationships#followings", as: "followings"
      get "followers", to: "relationships#followers", as: "followers"

      member do
        get :favorites
      end
    end
  end
end

Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
 root 'homes#top'
 resources :genres, only: [:index, :create, :edit, :update]
 resources :users, only: [:index, :show, :edit, :update]
end


devise_scope :user do
 post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
end


scope module: :public do
root :to =>"homes#top"
get "homes/about"=>"homes#about"

resources :users 
resources :posts, only: [:index,:show,:edit,:new,:create,:destroy,:update] do


end



end

end
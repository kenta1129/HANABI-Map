Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

end

root :to =>"homes#top"
get "homes/about"=>"homes#about"

resources :posts, only: [:index,:show,:edit,:create,:destroy,:update] do

end

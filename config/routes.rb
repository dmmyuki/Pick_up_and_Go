Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources:posts do
      resources:comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
    end
    resources:users, only:[:show, :edit, :update] do
      get 'my_page' => 'users#my_page'
      get 'suspended' => 'users#suspended'
    end
  end

  namespace :admin do
  end

  get "search" => "searches#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

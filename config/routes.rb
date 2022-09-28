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
    get 'search' => 'searches#search'
    post 'guest_sign_in' => 'sessions#guest_sign_in'
    resources:posts do
      get 'search_tag/:id' => 'posts#search_tag', as: :search_tag
      resources:comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
    end
    resources:users, only:[:show, :edit, :update] do
      get 'my_page' => 'users#my_page'
      get 'suspended' => 'users#suspended'
    end
  end

  namespace :admin do
    get 'search' => 'searches#search'
    resources:posts, only:[:index, :show, :destroy] do
      get 'search_tag/:id' => 'posts#search_tag', as: :search_tag
    end
    resources:users, only:[:index, :show, :edit, :update] do
      patch 'suspended' => 'users#suspended'
    end
    resources:comments, only:[:index, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

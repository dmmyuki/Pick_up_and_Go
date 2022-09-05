Rails.application.routes.draw do

  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
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
    resources:posts
    resources:users, only:[:show, :edit, :update] do
      get 'my_page' => 'users#my_page'
      get 'suspended' => 'users#suspended'
    end
  end

  namespace :admin do
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

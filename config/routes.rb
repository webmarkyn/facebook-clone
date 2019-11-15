Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
  end
  devise_for :users
  authenticated :user do
    root 'posts#index', as: 'logged_in_root'
    get '/users/', to: 'users#index', as: 'users'
  end
  root 'pages#home', as: 'root'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

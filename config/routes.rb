Rails.application.routes.draw do
  resources :comments
  resources :likes
  resources :posts
  devise_for :users
  authenticated :user do
    root 'posts#index', as: 'logged_in_root'
    get '/users/', to: 'users#index', as: 'users'
  end
  root 'pages#home', as: 'root'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

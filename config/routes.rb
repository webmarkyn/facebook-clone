Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy, :edit, :update]
    resources :likes, only: [:create, :destroy]
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    root 'posts#index', as: 'logged_in_root'
    resources :users, only: [:index] do
      resources :friendships, only: [:create]
    end
    get 'users/:user_id/friends', to: 'users#friends', as: 'users_friends'
    get 'friend_requests/', to: 'users#friend_requests', as: 'user_friend_requests'
    put 'friend_requests/:requesting_user_id/:requested_user_id', to: 'friendships#accept', as: 'accept_friend_request'
    delete 'friend_requests/:requesting_user_id/:requested_user_id', to: 'friendships#delete', as: 'delete_friend_request'
  end
  root 'pages#home', as: 'root'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :todos

  # scope :auth do
  #   get 'sign-in', to: 'auth#sign_in', as: :sign_in
  #   post 'sign-in', to: 'auth#login', as: :login
  #   get 'sign-up', to: 'auth#sign_up', as: :sign_up
  #   post 'sign-up', to: 'auth#create_user', as: :create_user
  #   post 'logout', to: 'auth#logout', as: :logout
  # end

  namespace :api do
    get 'test', to: 'test#index', as: :test
    post 'users', to: 'auth#register', as: :register
    post 'sign-in', to: 'auth#sign_in', as: :sign_in

    resources :todos, only: [:index, :create, :update, :destroy]
  end

  root 'pages#home'
end


Rails.application.routes.draw do
  namespace :api do
    get 'test', to: 'test#index', as: :test
    post 'users', to: 'auth#register', as: :register
    post 'sign-in', to: 'auth#sign_in', as: :sign_in

    resources :todos, only: %i[index create update destroy]
  end
end

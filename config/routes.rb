Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root to: "users#new"
  resources :users
  resource :session, only: [:create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :tweets, only: [:create, :index, :show, :update, :destroy]
    resources :followers, only: [:create, :destroy]
  end
end

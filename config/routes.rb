Rails.application.routes.draw do
  root to: "users#new"
  resources :users
  resource :session, only: [:create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :tweets, only: [:create, :index, :show, :update, :destroy]
  end
end

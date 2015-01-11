Rails.application.routes.draw do
  root to: "users#new"
  resources :users
  resources :session, only: [:create]
end

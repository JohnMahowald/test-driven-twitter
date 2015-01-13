Rails.application.routes.draw do
  root to: "users#new"
  resources :users
  resource :session, only: [:create, :delete]
end

Rails.application.routes.draw do
  devise_for :users
  root to: "home#index", via: :get
  get 'dashboard', to: "companies#dashboard"
  resources :members
end

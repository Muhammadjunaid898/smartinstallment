Rails.application.routes.draw do
  devise_for :users
  root to: "home#index", via: :get
  constraints subdomain: /.+/ do 
  get 'dashboard', to: "companies#dashboard"
  end
end

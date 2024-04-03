Rails.application.routes.draw do
  constraints subdomain: /.+/ do 
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      sessions: 'users/sessions',
      confirmations: 'users/confirmations'
    }
    resources :members
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
      get 'login_across_session', to: 'users/sessions#login_across_session'
    end
    get 'dashboard', to: "companies#dashboard"
  end
  constraints(subdomain: '') do
    root to: "home#index", via: :get
    devise_for :users, only: :registrations, controllers: {
      registrations: 'users/registrations'
    }
    resources :user_companies, only: :index do
      get 'find', on: :collection
    end
  end
end

Rails.application.routes.draw do
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :customer do
    devise_for :users,
      class_name: "Customer::User",
      path: "",
      path_names: {
         sign_in:  "login",
         sign_out: "logout",
         sign_up:  "register",
         password: "password"
      },
      controllers: {
        registrations: "customer/devise/registrations",
        sessions: "customer/devise/sessions",
        passwords: "customer/devise/passwords",
        confirmations: "customer/devise/confirmations",
        unlocks: "customer/devise/unlocks"
      }

    devise_scope :user do
      get    "login",     to: "devise/sessions#new",     as: :login
      post   "login",     to: "devise/sessions#create"
      delete "logout",    to: "devise/sessions#destroy", as: :logout

      get    "register",  to: "devise/registrations#new",    as: :register
      post   "register",  to: "devise/registrations#create"

      get    "password/new", to: "devise/passwords#new",    as: :new_password
      post   "password",     to: "devise/passwords#create", as: :password
    end

    # Pages
    get "/", to: "home#index", as: :home
    get "/dashboard", to: "home#dashboard", as: :dashboard

    # Transactions
    post "/transactions", to: "transactions#create", as: :transactions
  end

  namespace :arc do
    devise_for :arc_accounts,
      class_name: "Arc::ArcAccount",
      path: "",
      path_names: {
         sign_in:  "login",
         sign_out: "logout",
         sign_up:  "register",
         password: "password"
      },
      controllers: {
        registrations: "arc/devise/registrations",
        sessions: "arc/devise/sessions",
        passwords: "arc/devise/passwords",
        confirmations: "arc/devise/confirmations",
        unlocks: "arc/devise/unlocks"
      }

    devise_scope :arc_account do
      get    "login",     to: "devise/sessions#new",     as: :login
      post   "login",     to: "devise/sessions#create"
      delete "logout",    to: "devise/sessions#destroy", as: :logout

      get    "register",  to: "devise/registrations#new",    as: :register
      post   "register",  to: "registrations#create"

      get    "password/new", to: "passwords#new",    as: :new_password
      post   "password",     to: "passwords#create", as: :password
    end

    # Pages
    get "/", to: "home#index", as: :home
    get "/dashboard", to: "home#dashboard", as: :dashboard

    # Transactions
    post "/transactions/:id/finalize", to: "transactions#finalize", as: :finalize_transaction

    # Roles
    post "/roles/assign", to: "roles#assign", as: :assign_role

    # Customer Accounts
    post "/customer_accounts/status", to: "customer_accounts#update_status", as: :update_customer_account_status
  end
end

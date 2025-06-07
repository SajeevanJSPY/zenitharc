Rails.application.routes.draw do
  root "home#index"
  get "home/dashboard"

  namespace :customer do
    devise_for :users,
      class_name: "Customer::User",
      path: "",
      controllers: {
        sessions: "customer/sessions"
      }
      post "/make_transaction", to: "transactions#make_transaction", as: :make_transaction
  end

  namespace :arc do
    devise_for :arc_accounts,
      class_name: "Arc::ArcAccount",
      path: "arc",
      controllers: {
        sessions: "arc/sessions"
      }

      post "/finalize_transaction/:id", to: "transactions#finalize_transaction", as: :finalize_transaction
      post "/assign_role", to: "roles#assign", as: :assign_role
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

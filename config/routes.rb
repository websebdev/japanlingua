Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  resources :contexts, only: [ :index, :show ] do
    resources :situations, only: [ :show ], module: :contexts
  end
  resources :flashcards, only: [ :index ]

  get "dashboard", to: "dashboard#index"

  namespace :admin do
    root "contexts#index"
    resources :contexts, only: [ :index, :show ] do
      resources :situations, module: :contexts do
        resources :sentences, only: [ :create, :destroy ], module: :situations
      end
    end
  end

  get "signup", to: "users#new", as: "signup"
  post "signup", to: "users#create"
  get "signin", to: "sessions#new", as: "signin"
  post "signin", to: "sessions#create"
  delete "signout", to: "sessions#destroy", as: "signout"
end

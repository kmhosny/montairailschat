Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :users
  post "/chat" => "open_ai_chat#create"
  
  get "/" => "sessions#show"
  get "/login" => "sessions#show"
  get "/signup" => "users#index"
  post "/login" => "sessions#new"
  delete "/logout" => "sessions#destroy"

  namespace :api do
    post :login, to: 'authentication#login'
    post :signup, to: 'authentication#signup'
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

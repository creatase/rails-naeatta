Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users do
    member do
      get :following, :followers
    end
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/post", to: "seedlingsposts#new"
  post "/post", to: "seedlingsposts#create"
  resources :seedlingsposts

  resources :relationships, only: [:create, :destroy]
end

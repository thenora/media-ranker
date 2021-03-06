Rails.application.routes.draw do
  root to: 'works#home'

  resources :works do
    resources :votes, only: [:create]
  end

  resources :users, only: [:index, :show]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

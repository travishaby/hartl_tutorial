Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]

  root "static_pages#home"
  get "home", to: "static_pages#home"
  get "help", to: "static_pages#help"
  get "about", to: "static_pages#about"
  get "contact", to: "static_pages#contact"
  get "signup", to: "users#new"
end

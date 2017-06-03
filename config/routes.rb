Rails.application.routes.draw do
  root 'home#index'

  resources :cards
  post '/check_card', to: 'cards#check_card'

  resources :users
  resources :user_sessions, only: [:create]

  get '/signup', to: 'users#new', as: :signup
  get '/login', to: 'user_sessions#new', as: :login
  post '/logout', to: 'user_sessions#destroy', as: :logout


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'oauths/oauth'

  get 'oauths/callback'

  root 'home#index'

  resources :decks do
    resources :cards
  end

  post '/check_card', to: 'cards#check_card'

  resources :users
  resources :user_sessions, only: [:create]

  get '/signup', to: 'users#new', as: :signup
  get '/login', to: 'user_sessions#new', as: :login
  post '/logout', to: 'user_sessions#destroy', as: :logout

  get 'oauth/callback', to: 'oauths#callback' # for use with Github, Facebook
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

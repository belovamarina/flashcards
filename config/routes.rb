Rails.application.routes.draw do
  root 'home#index'
  post '/check_card', to: 'cards#check_card'
  resources :cards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

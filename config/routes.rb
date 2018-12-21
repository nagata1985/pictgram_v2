Rails.application.routes.draw do

  root 'tops#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #get 'comments/new'
  #post '/comments', to: 'comments#create'

  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete '/favorites', to: 'favorites#delete'

  get 'users/favorites'

  resources :users
  resources :topics
  resources :comments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

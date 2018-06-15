Rails.application.routes.draw do
  devise_for :users
  root 'films#index'

  resources :films, only: %i[index create new destroy]
end

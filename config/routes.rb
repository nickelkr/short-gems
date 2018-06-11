Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :films, only: %i[index create new destroy]
end

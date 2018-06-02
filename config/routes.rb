Rails.application.routes.draw do
  root 'welcome#index'

  resources :films, only: %i[index create new destroy]
end

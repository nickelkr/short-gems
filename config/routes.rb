Rails.application.routes.draw do
  devise_for :users
  root 'films#index'

  resources :films, only: %i[index show create new destroy] do
    resources :applauses, only: %i[create destroy]
  end
end

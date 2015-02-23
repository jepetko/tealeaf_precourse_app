Rails.application.routes.draw do
  resources :groups

  root to: 'visitors#index'
  resources :users
end

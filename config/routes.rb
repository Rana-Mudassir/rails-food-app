Rails.application.routes.draw do
  devise_for :users

  
  resources :foods

  get 'users/index'

  root "pages#home"
end

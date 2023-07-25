Rails.application.routes.draw do
  devise_for :users


  resources :foods
  resources :public_recipes, only: %i[index]

  get 'users/index'

  root "pages#home"
end

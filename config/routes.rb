Rails.application.routes.draw do
  devise_for :users

  get 'users/index'
  root "pages#home"

  resources :inventories do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

end
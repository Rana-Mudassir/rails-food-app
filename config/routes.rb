Rails.application.routes.draw do
  devise_for :users


  resources :foods
  resources :public_recipes, only: %i[index]

  resources :recipes do 
    resources :recipe_foods, only: %i[create destroy new]
  end

  get 'users/index'

  root "pages#home"
end

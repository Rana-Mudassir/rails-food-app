Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: 'pages#home', as: :authenticated_root
    end

    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
  resources :foods
  resources :public_recipes, only: %i[index]


  resources :recipes do 
    resources :recipe_foods, only: %i[create destroy new]
  end

  #get 'users/index'


  root "pages#home"

  resources :inventories do
    resources :inventory_foods, except: :show
  end

end


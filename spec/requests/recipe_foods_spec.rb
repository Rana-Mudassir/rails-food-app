require 'rails_helper'

RSpec.describe 'RecipeFoods', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    sign_in @user
    @recipe = Recipe.create(user: @user, name: 'Test Recipe', preparation_time: 10, cooking_time: 20,
                            description: 'A delicious recipe', public: true)
    @food = Food.create(name: 'Test Food', measurement_unit: 'kg', price: '1')
  end

  describe 'GET /recipe_foods/new' do
    it 'returns a successful response' do
      get new_recipe_recipe_food_path(recipe_id: @recipe.id) # Replace 1 with the ID of an existing recipe
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /recipe_foods' do
    let!(:food) { Food.create(name: 'Ingredient 1') }
    let!(:recipe) do
      Recipe.create(user: @user, name: 'Test Recipe', preparation_time: 10, cooking_time: 20,
                    description: 'A delicious recipe', public: true)
    end

    context 'with valid attributes' do
      it 'creates a new recipe food' do
        allow(Food).to receive(:all).and_return([@food]) # Stub Food.all method
        expect do
          post recipe_recipe_foods_path(recipe), params: { recipe_food: { food_id: @food.id, quantity: 2 } }
        end.to change(RecipeFood, :count).by(1)

        expect(response).to redirect_to(recipe_path(recipe))
        expect(flash[:notice]).to eq('Ingredient was added successfully.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new recipe food' do
        expect do
          post recipe_recipe_foods_path(recipe), params: { recipe_food: { food_id: nil, quantity: 2 } }
        end.not_to change(RecipeFood, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /recipe_foods/:id' do
    let!(:food) { Food.create(name: 'Ingredient 1') }
    let!(:recipe) do
      Recipe.create(user: @user, name: 'Test Recipe', preparation_time: 10, cooking_time: 20,
                    description: 'A delicious recipe', public: true)
    end
    # Use @recipe instead of recipe and @food instead of food
    let!(:recipe_food) do
      RecipeFood.create(recipe: @recipe, food: @food, quantity: 2)
    end
    it 'destroys the recipe food' do
      expect do
        delete recipe_recipe_food_path(recipe_id: @recipe.id, id: recipe_food.id) # Use recipe_recipe_food_path with recipe_id and id
      end.to change(RecipeFood, :count).by(-1)

      expect(response).to redirect_to(recipe_path(@recipe)) # Use @recipe instead of recipe
      expect(flash[:notice]).to eq('Ingredient was deleted')
    end
  end
end

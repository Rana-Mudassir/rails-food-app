require 'rails_helper'

RSpec.describe 'Recipe', type: :model do
  before :each do
    @user = User.create(name: 'Test', email: 'test@example.com', password: 'password')
    @recipe = Recipe.create(user: @user, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                            description: 'test test', public: true)
    @test_food = Food.create(name: 'test food', measurement_unit: 2, price: 10)
    @recipe_food = RecipeFood.create(quantity: 10, food: @test_food, recipe: @recipe)
  end

  it 'RecipeFood model field should be equal to test recipe_food' do
    expect(@recipe_food.quantity).to eq 10
    expect(@recipe_food.food).to eq @test_food
    expect(@recipe_food.recipe).to eq @recipe
  end
end

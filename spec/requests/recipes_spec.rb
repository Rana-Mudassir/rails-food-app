require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    sign_in @user
  end

  describe 'GET /recipes' do
    it 'returns a successful response' do
      get recipes_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /recipes/:id' do
    let(:recipe) do
      Recipe.create(user: @user, name: 'Test Recipe', preparation_time: 10, cooking_time: 20,
                    description: 'A delicious recipe', public: true)
    end

    it 'returns a successful response' do
      get recipe_path(recipe)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get new_recipe_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new recipe' do
        expect do
          post recipes_path,
               params: { recipe: { name: 'New Recipe', preparation_time: 10, cooking_time: 20,
                                   description: 'A delicious recipe', public: true } }
        end.to change(Recipe, :count).by(1)

        expect(response).to redirect_to(recipes_path)
        expect(flash[:notice]).to eq('Recipe Created Successfully')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new recipe' do
        expect do
          post recipes_path,
               params: { recipe: { name: '', preparation_time: 10, cooking_time: 20, description: 'A delicious recipe',
                                   public: true } }
        end.not_to change(Recipe, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /recipe/:id' do
    let!(:recipe) do
      Recipe.create(user: @user, name: 'Test Recipe', preparation_time: 10, cooking_time: 20,
                    description: 'A delicious recipe', public: true)
    end

    it 'destroys the recipe' do
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(-1)

      expect(response).to redirect_to(recipes_path)
      expect(flash[:notice]).to eq('Recipe Destroyed Successfully')
    end
  end
end

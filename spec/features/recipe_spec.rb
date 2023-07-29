require 'rails_helper'

RSpec.describe 'Recipes', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before do
    # Log in the user before each test
    login_as(user, scope: :user)
  end

  describe 'Recipe list index page' do
    before do
      @recipe1 = Recipe.create(user:, name: 'Test Recipe 1', preparation_time: 10, cooking_time: 20,
                               description: 'A delicious recipe', public: true)
      @recipe2 = Recipe.create(user:, name: 'Test Recipe 2', preparation_time: 15, cooking_time: 25,
                               description: 'Another delicious recipe', public: true)
      visit recipes_path
    end

    it 'displays a list of recipes with their names' do
      expect(page).to have_content('Test Recipe 1')
      expect(page).to have_content('Test Recipe 2')
    end

    it 'displays the recipe description' do
      expect(page).to have_content('A delicious recipe')
      expect(page).to have_content('Another delicious recipe')
    end

    it 'shows the "Add Recipe" link for logged-in users' do
      expect(page).to have_link('Add Recipe', href: new_recipe_path)
    end

    it 'allows logged-in users to delete recipe items' do
      expect(page).to have_button('Remove', count: 2)
    end

    it 'navigates to the "Add Recipe" page when "Add Recipe" link is clicked' do
      click_link 'Add Recipe'
      expect(current_path).to eq(new_recipe_path)
    end
  end

  context 'Recipe list is empty' do
    before do
      Recipe.destroy_all
      visit recipes_path
    end

    it 'shows the "Add Recipe" link for logged-in users when the list is empty' do
      expect(page).to have_link('Add Recipe', href: new_recipe_path)
    end
  end
end

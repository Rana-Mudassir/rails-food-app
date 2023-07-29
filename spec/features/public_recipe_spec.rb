require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before :each do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    @public_recipe = Recipe.create!(user_id: user.id, name: 'public recipe', preparation_time: '1 hr',
                                    cooking_time: '1.5 hrs', description: 'Recipe description', public: true)
    @private_recipe = Recipe.create!(user_id: user.id, name: 'private recipe', preparation_time: '1 hr',
                                     cooking_time: '1.5 hrs', description: 'Recipe description', public: false)

    visit '/public_recipes'
  end

  describe 'Recipe' do
    scenario 'Public recipe is displayed on public_recipes page' do
      expect(page).to have_content(@public_recipe.name)
    end

    scenario 'Private recipe is not displayed on public_recipes page' do
      expect(page).not_to have_content(@private_recipe.name)
    end
  end
end

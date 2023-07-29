require 'rails_helper'

RSpec.describe 'Foods', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before do
    # Log in the user before each test
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  describe 'Food list index page' do
    before do
      @food1 = Food.create(name: 'Jolof', measurement_unit: '2 kg', price: 50)
      @food2 = Food.create(name: 'Fish', measurement_unit: '3 kg', price: 100)
      visit '/foods'
    end

    it 'displays a list of foods with their names' do
      expect(page).to have_content('Jolof')
      expect(page).to have_content('Fish')
    end

    it 'displays the measurement unit for each food' do
      expect(page).to have_content('2 kg')
      expect(page).to have_content('3 kg')
    end

    it 'displays the correct unit price for each food' do
      expect(page).to have_content('$50')
      expect(page).to have_content('$100')
    end

    it 'shows the "Add Food" link for logged-in users' do
      expect(page).to have_link('Add Food', href: new_food_path)
    end

    it 'allows logged-in users to delete food items' do
      expect(page).to have_button('DELETE', count: 2)
    end

    it 'navigates to the "Add Food" page when "Add Food" link is clicked' do
      click_link 'Add Food'
      expect(current_path).to eq(new_food_path)
    end
  end

  context 'Food list is empty' do
    before do
      Food.destroy_all
      visit '/foods'
    end

    it 'displays a message when the food list is empty' do
      expect(page).to have_content('Add New Foods Currently You Do Not Have Any Foods In The List')
    end

    it 'shows the "Add Food" link for logged-in users when the list is empty' do
      expect(page).to have_link('Add Food', href: new_food_path)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Inventories', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before do
    # Log in the user before each test
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  describe 'Inventory index page' do
    before do
      @inventory1 = Inventory.create(name: 'Inventory 1')
      @inventory2 = Inventory.create(name: 'Inventory 2')
      visit '/inventories'
    end

    it 'displays a list of inventories with their names' do
      expect(page).to have_content('Inventory 1')
      expect(page).to have_content('Inventory 2')
    end

    it 'allows logged-in users to delete inventories' do
      expect(page).to have_button('DELETE', count: 2)
    end

    it 'navigates to the "Add Inventory" page when "Add Inventory" link is clicked' do
      click_link 'Add Inventory'
      expect(current_path).to eq(new_inventory_path)
    end
  end

  context 'Inventory list is empty' do
    before do
      Inventory.destroy_all
      visit '/inventories'
    end

    it 'displays a message when the inventory list is empty' do
      expect(page).to have_content('Add New Inventory Currently You Do Not Have Any Inventory In The List')
    end

    it 'shows the "Add Inventory" link for logged-in users when the list is empty' do
      expect(page).to have_link('Add Inventory', href: new_inventory_path)
    end
  end

  describe 'New inventory page' do
    it 'allows logged-in users to create new inventories' do
      visit new_inventory_path
      fill_in 'Name', with: 'New Inventory'
      click_button 'Create Inventory'
      expect(page).to have_content('New Inventory was successfully created.')
    end

    it 'redirects to the inventory index page after creating a new inventory' do
      visit new_inventory_path
      fill_in 'Name', with: 'New Inventory'
      click_button 'Create Inventory'
      expect(current_path).to eq(inventories_path)
    end

    it 'does not allow logged-out users to create new inventories' do
      log_out
      visit new_inventory_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end

  describe 'Inventory show page' do
    before do
      @inventory = Inventory.create(name: 'Inventory 1')
      visit inventory_path(@inventory)
    end

    it 'displays the inventory name' do
      expect(page).to have_content('Inventory 1')
    end

    it 'does not allow logged-out users to view inventory show pages' do
      log_out
      visit inventory_path(@inventory)
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end

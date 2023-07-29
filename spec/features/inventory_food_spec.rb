require 'rails_helper'

RSpec.describe 'InventoryFoods', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }
  let!(:inventory) do
    inventory = Inventory.new(name: 'Inventory 1')
    inventory.user = user
    inventory.save!
    inventory
  end

  before do
    # Log in the user before each test
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'displays a form to add a food to an inventory' do
    visit url_for(controller: 'inventory_foods', action: 'new', inventory_id: inventory.id)
    expect(page).to have_field('Food')
    expect(page).to have_field('Quantity')
    expect(page).to have_button('Add Food')
  end
end

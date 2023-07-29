require 'rails_helper'

RSpec.describe 'InventoryFoods', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    sign_in @user
  end

  context 'testing request' do
    it 'GET /inventories/:id/inventory_foods/new' do      
      user = User.create!(name: 'Goodman', email: 'bogdan@example.com', password: 'password')
      inventory = user.inventories.create!(name: 'Inv#1')
      sign_in user
      get("/inventories/#{inventory.id}/inventory_foods/new")
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end    
  end
end

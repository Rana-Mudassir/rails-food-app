require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    sign_in @user
  end

  describe 'testing request' do
    it 'GET /foods' do
      get('/foods')
      expect(response).to render_template('index')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /foods/:id' do
      food = Food.create!(name: 'Food #1', measurement_unit: 'h', price: 15)
      get('/foods/new')
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it 'GET /foods/new' do
      get('/foods/new')
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it 'POST /foods' do
      food_params = {
        name: 'Food #n',
        measurement_unit: 'g',
        price: 10
      }
      post('/foods', params: { food: food_params })
      get('/foods/new')
      expect(Food.last.name).to eq 'Food #n'
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end

    it 'DELETE /foods/:id should not render show template' do
      food = Food.create!(name: 'Food #n', measurement_unit: 'g', price: 10)
      delete("/foods/#{food.id}")
      expect(response.body).not_to include('Food #n')
    end
  end
end

require 'rails_helper'

RSpec.describe Food, type: :model do
  before :each do
    @food = Food.create(name: 'Jolof', measurement_unit: '3', price: 1)
  end

  it 'should have a name' do
    food_name = @food.name
    expect(food_name).to eq('Jolof')
  end

  it 'should contain the measurement' do
    expect(@food.measurement_unit).to eq '3'
  end

  it 'should contain the price' do
    expect(@food.price).to eq 1
  end

  it 'should have valid attributes' do
    expect(@food).to be_valid
  end
end
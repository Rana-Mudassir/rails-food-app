require 'rails_helper'

RSpec.describe Inventory, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  before :each do
    @inventory = Inventory.create(
      name: 'My Inventory',
      user_id: user.id,
    )
  end

  it 'should have a name' do
    expect(@inventory.name).to eq('My Inventory')
  end
  
  it 'should not be valid without a name' do
    @inventory.name = nil
    expect(@inventory).not_to be_valid
  end

  it 'should have a unique name per user' do
    duplicate_inventory = Inventory.new(
      name: 'My Inventory',
      user_id: user.id,
    )
    expect(duplicate_inventory).not_to be_valid
  end
end

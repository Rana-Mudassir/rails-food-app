class AddQuantityUnitToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :quantity_unit, :string
  end
end

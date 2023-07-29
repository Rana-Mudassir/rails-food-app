class AddQuantityUnitToRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :recipe_foods, :quantity_unit, :string
  end
end

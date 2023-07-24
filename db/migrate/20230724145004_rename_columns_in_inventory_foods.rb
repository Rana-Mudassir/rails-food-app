class RenameColumnsInInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    rename_column :inventory_foods, :inventories_id, :inventory_id
    rename_column :inventory_foods, :foods_id, :food_id
  end
end

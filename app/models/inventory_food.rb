class InventoryFood < ApplicationRecord
  belongs_to :inventory
  belongs_to :food

  validates :quantity, comparison: { greater_than: 0 }  
end

class Inventory < ApplicationRecord
  has_many :inventory_foods
  has_many :foods, through: :inventory_foods

  validates :name, presence: true
end

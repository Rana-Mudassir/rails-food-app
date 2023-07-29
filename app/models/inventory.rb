class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_foods
  has_many :foods, through: :inventory_foods
  
  validates :description, presence: true
  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
end

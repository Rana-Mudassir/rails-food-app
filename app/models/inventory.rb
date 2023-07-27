class Inventory < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  has_many :inventory_foods
  has_many :foods, through: :inventory_foods

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
end

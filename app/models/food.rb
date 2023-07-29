class Food < ApplicationRecord
  has_many :inventory_foods
  has_many :inventories, through: :inventory_foods
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true

  private

  def calculate_price
    self.price = self.price * self.quantity_unit.to_f if self.quantity_unit.present?
  end
end


class Product < ApplicationRecord
  # Each product belongs to one clothing category.
  belongs_to :category

  # Product name and description are required.
  validates :name, presence: true
  validates :description, presence: true

  # Price must be present and cannot be negative.
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }

  # Stock must be a whole number and cannot be negative.
  validates :stock_quantity, presence: true,
                             numericality: {
                               only_integer: true,
                               greater_than_or_equal_to: 0
                             }

  # Sale status must be either true or false.
  validates :on_sale, inclusion: { in: [true, false] }
end

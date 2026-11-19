
class Category < ApplicationRecord
  # A category can contain multiple products.
  has_many :products, dependent: :restrict_with_error

  # Every category must have a name and description.
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
end

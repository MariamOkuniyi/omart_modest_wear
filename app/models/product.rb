
class Product < ApplicationRecord
  # Each product belongs to one clothing category.
  belongs_to :category

  # Attach one product image using Rails Active Storage.
  has_one_attached :image

  # Validate uploaded product images.
  validate :acceptable_image

  private

  def acceptable_image
    return unless image.attached?

    unless image.blob.content_type.in?(%w[image/jpeg image/png image/webp])
      errors.add(:image, "must be a JPG, PNG, or WebP image")
    end

    if image.blob.byte_size > 5.megabytes
      errors.add(:image, "must be smaller than 5 MB")
    end
  end

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
  validates :on_sale, inclusion: { in: [ true, false ] }
  def self.ransackable_associations(auth_object = nil)
    [ "category" ]
  end
  def self.ransackable_attributes(auth_object = nil)
    %w[id category_id name description price stock_quantity on_sale created_at updated_at]
  end
end

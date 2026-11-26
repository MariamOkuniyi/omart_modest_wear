class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  belongs_to :province, optional: true

  # Devise authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
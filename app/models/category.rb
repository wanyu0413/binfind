class Category < ApplicationRecord
  has_many :bin_categories
  has_many :bins, through: :bin_categories
  validates :name, presence: true
end

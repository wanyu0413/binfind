class Bin < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
  has_many :bin_categories
  has_many :categories, through: :bin_categories
  has_many_attached :photos
  validates :name, presence: true
end

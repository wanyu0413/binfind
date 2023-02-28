class Bin < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user
  has_many_attached :photos
  validates :category, :name, :open_time, :end_time, presence: true
end

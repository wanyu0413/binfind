class Category < ApplicationRecord
  has_many :bin_categories
  has_many :bins, through: :bin_categories
  validates :name, presence: true
  def icon
    case name
    when "burnable" then "fa-dumpster-fire"
    when "pet bottle" then "fa-wine-bottle"
    when "unburnable" then "fa-circle-xmark"
    else
      "fa-prescription-bottle"
    end
  end
end

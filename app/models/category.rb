class Category < ApplicationRecord
  has_many :bin_categories
  has_many :bins, through: :bin_categories
  validates :name, presence: true
  def icon
    case name
    when "burnable" then "jpic-kanen"
    when "pet bottle" then "jpic-pettobotoru"
    when "unburnable" then "jpic-kaki-genkin"
    else
      "jpic-kan"
    end
  end
end

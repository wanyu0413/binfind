class AddCoordinatesToBins < ActiveRecord::Migration[7.0]
  def change
    add_column :bins, :latitude, :float
    add_column :bins, :longitude, :float
  end
end

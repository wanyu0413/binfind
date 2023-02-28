class AddAddressToBins < ActiveRecord::Migration[7.0]
  def change
    add_column :bins, :address, :string
  end
end

class ChangeBinsTime < ActiveRecord::Migration[7.0]
  def change
    change_column :bins, :open_time, :string
    change_column :bins, :end_time, :string
  end
end

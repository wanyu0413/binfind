class CreateBins < ActiveRecord::Migration[7.0]
  def change
    create_table :bins do |t|
      # t.string :category
      t.string :name
      t.boolean :capacity
      t.time :open_time
      t.time :end_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

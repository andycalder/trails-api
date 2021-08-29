class CreateTrails < ActiveRecord::Migration[6.0]
  def change
    create_table :trails do |t|
      t.string :name
      t.string :difficulty
      t.string :category
      t.string :zone
      t.float :start_lat
      t.float :start_lng

      t.timestamps
    end
  end
end

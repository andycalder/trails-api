class AddMapboxIdToTrail < ActiveRecord::Migration[6.0]
  def change
    add_column :trails, :mapbox_id, :string
  end
end

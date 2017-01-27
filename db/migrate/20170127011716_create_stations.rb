class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.text    :name
      t.integer :city_id
      t.integer :dock_count_id
      t.integer :installation_date_id

      t.timestamps null: false
    end
  end
end

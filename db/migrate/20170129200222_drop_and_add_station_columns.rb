class DropAndAddStationColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :stations, :installation_date_id, :integer
    remove_column :stations, :dock_count_id, :integer
    add_column :stations, :installation_date, :date
    add_column :stations, :dock_count, :integer
  end
end

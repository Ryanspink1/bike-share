class CreateDockCounts < ActiveRecord::Migration[5.0]
  def change
    create_table :dock_counts do |t|
      t.integer :dock_number

      t.timestamps null: false
    end
  end
end

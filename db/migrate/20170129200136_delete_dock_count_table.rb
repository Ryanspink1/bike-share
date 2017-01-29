class DeleteDockCountTable < ActiveRecord::Migration[5.0]
  def change
    drop_table  :dock_counts
  end
end

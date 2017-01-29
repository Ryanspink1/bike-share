class DeleteInstallationDateTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :installation_dates
  end
end

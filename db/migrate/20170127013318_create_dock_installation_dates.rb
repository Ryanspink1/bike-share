class CreateDockInstallationDates < ActiveRecord::Migration[5.0]
  def change
    create_table :installation_dates do |t|
      t.date :installation_date

      t.timestamps null: false
    end
  end
end

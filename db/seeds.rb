require_relative '../app/models/city.rb'
require_relative '../app/models/dock_count.rb'
require_relative '../app/models/installation_date.rb'
require_relative '../app/models/station.rb'
require 'csv'
require 'pry'

City.destroy_all
DockCount.destroy_all
InstallationDate.destroy_all
Station.destroy_all



contents = CSV.open('db/csv/station.csv', headers: true, header_converters: :symbol)

#We REALLY need to refactor this, sorry Ashley. 
def date_format(date)
  date_parts = date.split('/')
  date_parts = [date_parts[-1], date_parts[0], date_parts[1]]
  fixed = date_parts.map do |part|
    if part.length < 2
      "0" + part
    else
      part
    end
  end
  date =  fixed.join
  date
end


contents.each do |row|

  Station.create(name: row[:name],
                 city_id: City.find_or_create_by(name: row[:city]).id,
                 dock_count_id: DockCount.find_or_create_by(dock_number: row[:dock_count]).id,
                 installation_date_id: InstallationDate.find_or_create_by(installation_date: date_format(row[:installation_date])).id,
                 )
end
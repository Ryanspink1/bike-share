require_relative '../app/models/city.rb'
require_relative '../app/models/station.rb'
require 'csv'
require 'pry'

City.destroy_all
Station.destroy_all



contents = CSV.open('db/csv/station.csv', headers: true, header_converters: :symbol)

#We REALLY need to refactor this, sorry Ashley.
def date_format(date)
  Date.strptime(date, '%m/%d/%Y')
end


contents.each do |row|

  Station.create(name: row[:name],
                 city_id: City.find_or_create_by(name: row[:city]).id,
                 dock_count: row[:dock_count],
                 installation_date: date_format(row[:installation_date])
                 )
end

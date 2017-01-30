require_relative '../app/models/city.rb'
require_relative '../app/models/station.rb'
require_relative '../app/models/trip.rb'
require 'csv'
require 'pry'
require 'activerecord-import'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'


City.destroy_all
Station.destroy_all
Trip.destroy_all


station_contents = CSV.open('db/csv/station.csv', headers: true, header_converters: :symbol)

station_contents.each do |row|
  station = Station.new(
    name: row[:name],
    city_id: City.find_or_create_by(name: row[:city]).id,
    dock_count: row[:dock_count],
    installation_date: Date.strptime(row[:installation_date], '%m/%d/%Y')
  ) do |s|
    s.id = row[:id]
  end
  station.save!
end

puts "station.csv file upload complete!"


start_time = Time.now
trip_contents = CSV.open('db/csv/trip.csv', headers: true, header_converters: :symbol)

trips_list = trip_contents.map do |row|
  [
    row[:duration],
    row[:start_date],
    row[:start_station_id],
    row[:end_date],
    row[:end_station_id],
    row[:bike_id],
    row[:subscription_type],
    row[:zip_code]
  ]
end.uniq!

trips = []
trips_list.each_with_index do |row, i|
  trip = Trip.new(
    duration:          row[0],
    start_date:        DateTime.strptime(row[1], "%m/%d/%Y %H:%M"),
    start_station_id:  row[2],
    end_date:          DateTime.strptime(row[3], "%m/%d/%Y %H:%M"),
    end_station_id:    row[4],
    bike_id:           row[5],
    subscription_type: row[6].downcase,
    zip_code:          (row[7].rjust(5, "0") unless row[7].nil?)
  )
  if trips.length == 50000 || i == trips_list.length - 1
    Trip.import trips
    trips = []
  else
    trips << trip
  end
end

end_time = Time.now
duration = ((end_time - start_time) / 60).round(2)

puts "trip.csv file upload complete! (#{Trip.count} records in #{duration} minutes)"
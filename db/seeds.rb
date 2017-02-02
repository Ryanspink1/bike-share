require_relative '../app/models/city.rb'
require_relative '../app/models/station.rb'
require_relative '../app/models/trip.rb'
require_relative '../app/models/condition.rb'
require 'csv'
require 'pry'
require 'activerecord-import'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

station_csv = 'db/csv/station.csv'
trip_csv    = 'db/csv/trip.csv'
weather_csv = 'db/csv/weather.csv'

# station_csv = 'db/fixtures/station-fixture.csv'
# trip_csv    = 'db/fixtures/trip-fixture.csv'
# weather_csv = 'db/fixtures/weather-fixture.csv'


station_contents = CSV.open(station_csv, headers: true, header_converters: :symbol)

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
trip_contents = CSV.read(trip_csv, headers: true, header_converters: :symbol)

trips = []
ten_percent = (trip_contents.length * 0.1).round(0).to_i
trip_contents.each_with_index do |row, i|
  trip = Trip.new(
    duration:          row[:duration],
    start_date:        DateTime.strptime(row[:start_date], "%m/%d/%Y %H:%M"),
    start_station_id:  row[:start_station_id],
    end_date:          DateTime.strptime(row[:end_date], "%m/%d/%Y %H:%M"),
    end_station_id:    row[:end_station_id],
    bike_id:           row[:bike_id],
    subscription_type: row[:subscription_type].downcase,
    zip_code:          (row[:zip_code].rjust(5, "0") unless row[:zip_code].nil?)
  )
  if trips.length == ten_percent
    Trip.import trips
    trips = []
    puts "trip import status: #{i}/#{trip_contents.length} #{((Time.now - start_time) / 60).round(2)}"
  elsif i == trip_contents.length - 1
    trips << trip
    Trip.import trips
    trips = []
  else
    trips << trip
  end
end

end_time = Time.now
duration = ((end_time - start_time) / 60).round(2)

puts "trip.csv file upload complete! (#{Trip.count} records in #{duration} minutes)"

start_time = Time.now

condition_contents = CSV.read(weather_csv, headers: true, header_converters: :symbol)

conditions_list = []
ten_percent = (condition_contents.length * 0.1).round(0).to_i
condition_contents.each_with_index do |row, i|
  condition = Condition.new(date: Date.strptime(row[:date],"%m/%d/%Y"),
    max_temperature:    row[:max_temperature],
    min_temperature:    row[:min_temperature],
    mean_temperature:   row[:mean_temperature],
    mean_humidity:      row[:mean_humidity],
    mean_visibility:    row[:mean_visibility],
    mean_wind_speed:    row[:mean_wind_speed],
    mean_precipitation: row[:mean_precipitation],
  )
  if conditions_list.length == 1000
    Condition.import conditions_list
    conditions_list = []
  elsif i == condition_contents.length - 1
    conditions_list << condition
    Condition.import conditions_list
    conditions_list = []
  else
    conditions_list << condition
  end
end

Condition.all.each_with_index do |condition, i|
  condition.add_id_to_trips
  puts "weather import status: #{i}/#{Condition.count} #{((Time.now - start_time) / 60).round(2)} " if i % ten_percent == 0
end

end_time = Time.now
duration = ((end_time - start_time) / 60).round(2)

puts "weather.csv file upload complete! (#{Condition.count} records in #{duration} minutes)"


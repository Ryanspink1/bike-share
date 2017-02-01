require_relative '../app/models/city.rb'
require_relative '../app/models/station.rb'
require_relative '../app/models/trip.rb'
require_relative '../app/models/condition.rb'
require 'csv'
require 'pry'
require 'activerecord-import'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'
require 'faker'


5.times do
  City.create(name: Faker::Address.city)
end

25.times do
  Station.create(
    name: Faker::Address.street_name,
    city_id: rand(1..5),
    dock_count: rand(1..30),
    installation_date: Faker::Date.between_except(2.year.ago, 1.year.ago, Date.today)
  )
end

puts ""
puts ""
puts ""
puts ""
puts ""
Station.all.each do |station|
  station_line = [station.id, station.name, station.city.name, station.dock_count, station.installation_date.strftime("%m/%d/%Y")].join(",")
  puts station_line
end

5000.times do
  date = Time.now - rand(0..(60*60*24*365))
  diff = rand(0..60) + rand(0..60)*60 + rand(0..48)*60*60
  Trip.create(
    duration:          diff,
    start_date:        date,
    end_date:          date + diff,
    start_station_id:  rand(1..Station.count),
    end_station_id:    rand(1..Station.count),
    bike_id:           rand(1..(Station.sum(:dock_count)*1.2).to_i),
    subscription_type: ['subscriber', 'customer'].sample,
    zip_code:          5.times.reduce([]) { |zip_code| zip_code << rand(0..9).to_s }.join
  )
end

puts ""
puts ""
puts ""
puts ""
puts ""
Trip.all.each do |trip|
  trip_list = [trip.duration, trip.start_date.strftime("%m/%d/%Y %H:%M:%S"),trip.start_station_id.to_s,trip.end_date.strftime("%m/%d/%Y %H:%M:%S"),trip.end_station_id.to_s, trip.bike_id, trip.subscription_type.capitalize,trip.zip_code]
  puts trip_list.join(",")
end

365.times do |day|
  temps = [rand(0..100),rand(0..100),rand(0..100)].sort
  condition = Condition.create(
    date:               Date.today - day,
    max_temperature:    temps[0],
    min_temperature:    temps[2],
    mean_temperature:   temps[1],
    mean_humidity:      rand(25..75),
    mean_visibility:    rand(0..50),
    mean_wind_speed:    rand(0..20),
    mean_precipitation: rand(0.0..10.0).round(1)
  )
  condition.add_id_to_trips
end

puts ""
puts ""
puts ""
puts ""
puts ""
Condition.all.each do |condition|
  condition_list = [condition.date.strftime("%m/%d/%Y"), condition.max_temperature,condition.mean_temperature,condition.min_temperature,condition.mean_humidity,condition.mean_visibility,condition.mean_wind_speed,condition.mean_precipitation]
  puts condition_list.join(",")
end
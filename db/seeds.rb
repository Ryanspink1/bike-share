# require 'csv'
# require 'pry'
# require './app/models/station.rb'
# require './app/models/city.rb'
# require './app/models/installation_date.rb'
# require './app/models/dock_count.rb'

# def load(filename)
#   options = {
#     :headers => true,
#     :header_converters => :symbol,
#     :col_sep => ','
#   }

#   # binding.pry

#   table = CSV.open(filename, headers: true, header_converters: :symbol).read

#   cities = get_batch(table, :city)
#   cities.each do |city|
#     City.create(name: city)
#   end

#   dock_counts = get_batch(table, :dock_count)
#   dock_counts.each do |dock_count|
#     DockCount.create(dock_number: dock_count)
#   end

#   installation_dates = get_batch(table, :installation_date)
#   installation_dates.each do |installation_date|
#     formatted_date = format_date(installation_date)
#     InstallationDate.create(installation_date: installation_date)
#   end

#   #Instead of reading all the files at once, we instead break them into chunks
#   # CSV.foreach(filename, options) do |row|
#   #   stations << Station.new(
#   #     name: "name",
#   #     city: City.find_or_create_by()
#   #     )
#   #   #Breaking everything up helps with memory and improves speed
#   #   if stations.size % chunk_size == 0
#   #     #ar-extensions can create multiple database objects with a single statement through .import()
#   #     Station.import stations, :validate => validate
#   #     stations = []
#   #   end
#   # end
#   # Station.import stations, :validate => validate if stations.size > 0
# end

# def get_batch(table, column)
#   table[column].uniq
# end

# def format_date(date_str)
#   month, day, year = date_str.split("/")
#   day = day.length == 2 ? day : "0#{day}"
#   month = month.length == 2 ? day : "0#{month}"
#   [month, day, year].join("/")
# end

# load('./db/csv/station.csv')
# puts Station.count



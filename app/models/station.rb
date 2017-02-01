class Station < ActiveRecord::Base
  belongs_to :city
  has_many   :trips_started, :class_name => "Trip", :foreign_key => "start_station_id"
  has_many   :trips_ended,   :class_name => "Trip", :foreign_key => "end_station_id"
  validates  :name, presence: true
  validates  :city, presence: true
  validates  :dock_count, presence: true
  validates  :installation_date, presence: true

  def self.average_bikes_per_station
    average(:dock_count).round(0).to_i
  end

  def self.with_most_bikes
    where(dock_count: maximum(:dock_count)).order(:name)
  end

  def self.with_fewest_bikes
    where(dock_count: minimum(:dock_count)).order(:name)
  end

  def most_frequent_destination_station
    trips = self.trips_started
    trips_by_end_station = trips.group(:end_station).count
    trips_by_end_station.key(trips_by_end_station.values.max)
  end

  def most_frequent_starting_station
    trips = self.trips_ended
    trips_by_starting_station = trips.group(:start_station).count
    trips_by_starting_station.key(trips_by_starting_station.values.max)
  end

  def most_frequent_zip
    trips = self.trips_started
    trips_by_zip = trips.group(:zip_code).count
    trips_by_zip.key(trips_by_zip.values.max)
  end

  def most_frequent_bike
    trips = self.trips_started
    trips_by_bike = trips.group(:bike_id).count
    trips_by_bike.key(trips_by_bike.values.max)
  end

  def date_with_highest_number_of_trips
    trips = self.trips_started
    trips_on_day = trips.group_by {|trip| trip.start_date.to_s[0..9]}

    trips_by_day = {}

    trips_on_day.each{|date, trips| trips_by_day[date] = trips.count}

    trips_by_day.key(trips_by_day.values.max)
  end



end

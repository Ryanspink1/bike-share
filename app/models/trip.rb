class Trip < ActiveRecord::Base
  belongs_to :start_station, :class_name => "Station"
  belongs_to :end_station, :class_name => "Station"
  belongs_to :condition
  validates :duration, presence: true
  validates :start_date, presence: true
  validates :start_station_id, presence: true
  validates :end_date, presence: true
  validates :end_station_id, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true

  DURATION_FORMAT = "%H:%M:%S"
  TRIP_TIME_FORMAT = "%d:%H:%M:%S"
  DATE_FORMAT = "%m/%d/%Y %H:%M:%S"

  def formatted_duration
    Time.at(self.duration).utc.strftime(DURATION_FORMAT)
  end

  def formatted_start_date
    self.start_date.strftime(DATE_FORMAT)
  end

  def formatted_end_date
    self.end_date.strftime(DATE_FORMAT)
  end

  def self.subscription_type_list
    ["customer", "subscriber"]
  end

  def self.format_parameters(data)
    data["duration"]   = Trip.calculate_duration(data[:start_date], data[:end_date])
    data["start_date"] = Trip.unformatted_date(data[:start_date])
    data["end_date"]   = Trip.unformatted_date(data[:end_date])
    data["zip_code"]   = data[:zip_code].rjust(5,"0") unless data[:zip_code].empty?
    data
  end

  def self.unformatted_date(date_str)
    DateTime.strptime(date_str, DATE_FORMAT)
  end

  def self.calculate_duration(start_date_str, end_date_str)
    start_time = Time.strptime(start_date_str, DATE_FORMAT)
    end_time   = Time.strptime(end_date_str, DATE_FORMAT)
    (end_time - start_time).to_i
  end

  def self.average_duration
    # binding.pry
    Time.at(average(:duration).round(0).to_i).utc.strftime(TRIP_TIME_FORMAT)
  end

  def self.longest_ride
    Time.at(maximum(:duration)).utc.strftime(TRIP_TIME_FORMAT)
  end

  def self.shortest_ride
    Time.at(minimum(:duration)).utc.strftime(TRIP_TIME_FORMAT)
  end

  def self.most_rides_starting
    stations_by_rides = self.group(:start_station).count

    stations_by_rides.key(stations_by_rides.values.max)
  end

  def self.most_rides_ending
    stations_by_rides = self.group(:end_station).count

    stations_by_rides.key(stations_by_rides.values.max)
  end

  def self.group_by_bike
    group(:bike_id).count
  end

  def self.most_ridden_bike
    group_by_bike.key(group_by_bike.values.max)
  end

  def self.least_ridden_bike
    group_by_bike.key(group_by_bike.values.min)
  end

  def self.most_rides_on_a_bike
    group_by_bike.values.max
  end

  def self.least_rides_on_a_bike
    group_by_bike.values.min
  end

  def self.group_by_subscription_type
    group(:subscription_type).count
  end

  def self.number_of_subscribed
    num_of_subscribed = group_by_subscription_type["subscriber"]
    num_of_subscribed
  end

  def self.number_of_customers
    group_by_subscription_type["customer"]
  end

  def self.percentage_of_subscribed
    ((number_of_subscribed.to_f/self.count.to_f) * 100).round(0)
  end

  def self.percentage_of_customers
    ((number_of_customers.to_f/self.count.to_f) * 100).round(0)
  end

  def self.group_trip_by_date
    group(:start_date).count
  end

  def self.all_trips_by_date
    trips = self.group_trip_by_date
    trips.group_by { |trip| trip[0].to_s[0..9] }
  end

  def self.trips_by_date
    all_trips = self.all_trips_by_date
    all_trips.reduce({}) do |trips_by_date, (key, value)|
      if trips_by_date[value.count].nil?
        trips_by_date[value.count] = [key]
      else
        trips_by_date[value.count] << key
      end
      trips_by_date
    end
  end

  def self.date_with_most_rides

    (trips_by_date[trips_by_date.keys.max][0]).to_date.strftime("%m/%d/%Y")
  end

  def self.date_with_least_rides
    (trips_by_date[trips_by_date.keys.min][0]).to_date.strftime("%m/%d/%Y")
  end

  def self.month_by_month
    trips = self.group_trip_by_date
    month_breakdown = trips.group_by {|trip|
   (trip[0].to_s[0..3] + '/' + trip[0].to_s[8..9])}
    month_breakdown.reduce({}) do |month_by_month, (month, trips)|
        month_by_month.merge({month => trips.count})
    end
  end

end

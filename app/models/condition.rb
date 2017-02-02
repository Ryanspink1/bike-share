class Condition < ActiveRecord::Base
  has_many :trips

  DATE_FORMAT = "%m/%d/%Y"

  def formatted_date
    self.date.strftime(DATE_FORMAT)
  end

  def self.format_parameters(data)
    data["date"] = Condition.unformatted_date(data[:date])
    data
  end

  def self.unformatted_date(date_str)
    Date.strptime(date_str, DATE_FORMAT)
  end

  def add_id_to_trips
    day_start = Time.new(self.date.year, self.date.month, self.date.day, 0, 0, 0, 0)
    day_end = Time.new(self.date.year, self.date.month, self.date.day, 23, 59, 59, 0)
    trips = Trip.where("start_date >= ? AND start_date <= ?", day_start, day_end)
    trips.update(condition_id: self.id)
  end

  def remove_id_from_trips
    self.trips.update(condition_id: nil)
  end

  def date_same?(date)
    date == self.date
  end

  def self.rides_by_temperature
    temp_range = [[40,49],[50,59],[60,69],[70,79],[80,89]]
    rides_by_condition(:max_temperature, temp_range)
  end

  def self.rides_by_precipitation
    precip_range = [[0.0,0.49],[0.5,0.99]]
    rides_by_condition(:mean_precipitation, precip_range)
  end

  def self.rides_by_wind_speed
    wind_speed_range = [[0,3],[4,7],[8,11],[12,15],[16,19],[20,24]]
    rides_by_condition(:mean_wind_speed, wind_speed_range)
  end

  def self.rides_by_visibility
    visibility_range = [[4,7],[8,11]]
    rides_by_condition(:mean_visibility, visibility_range)
  end

  def self.rides_by_condition(weather_stat, condition_range)
    condition_range.reduce({}) do |rides_by_weather, stat_range|
      query = self.where("#{weather_stat} >= ? AND #{weather_stat} <= ?", stat_range[0], stat_range[1])
      trip_date = query.reduce({}) do |trips_per_date, condition|
        trips_per_date.merge!({condition.date => condition.trips.count})
      end
      key = stat_range.join(" - ")
      rides_by_weather.merge!({key => trip_date})
    end
  end
end

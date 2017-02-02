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
end

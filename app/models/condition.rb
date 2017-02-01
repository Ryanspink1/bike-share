class Condition < ActiveRecord::Base
  has_many :trips

  def add_id_to_trips
    day_start = Time.new(self.date.year, self.date.month, self.date.day, 0, 0, 0, 0)
    day_end = Time.new(self.date.year, self.date.month, self.date.day, 23, 59, 59, 0)
    trips = Trip.where("start_date >= ? AND start_date <= ?", day_start, day_end)
    trips.update(condition_id: self.id)
  end

  def remove_id_from_trips
    self.trips.update(condition_id: nil)
  end
end

class Trip < ActiveRecord::Base
  belongs_to :start_station, :class_name => "Station"
  belongs_to :end_station, :class_name => "Station"
  validates :duration, presence: true
  validates :start_date, presence: true
  validates :start_station_id, presence: true
  validates :end_date, presence: true
  validates :end_station_id, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true
  # validates :zip_code, presence: true

  def duplicate?
    trip = Trip.find_by(
      duration:          self.duration,
      start_date:        self.start_date,
      start_station_id:  self.start_station_id,
      end_date:          self.end_date,
      end_station_id:    self.end_station_id,
      bike_id:           self.bike_id,
      subscription_type: self.subscription_type,
      zip_code:          self.zip_code
    )
    !trip.nil?
  end

  def save
    @database.execute(
      "INSERT INTO robots (name, city, state, department, picture) VALUES (?, ?, ?, ?, ?);",
      @name, @city, @state, @department, @picture
    )
  end
end

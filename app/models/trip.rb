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

  DURATION_FORMAT = "%H:%M:%S"
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
    data["start_date"] = Trip.unformatted_date(data[:start_date])
    data["end_date"]   = Trip.unformatted_date(data[:end_date])
    data["duration"]   = (data["end_date"] - data["start_date"]).to_i
    data
  end

  def self.unformatted_date(date_str)
    Time.strptime(date_str, DATE_FORMAT)
  end

end

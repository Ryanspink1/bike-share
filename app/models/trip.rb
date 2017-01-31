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


end

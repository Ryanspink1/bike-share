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
  validates :zip_code, presence: true
end

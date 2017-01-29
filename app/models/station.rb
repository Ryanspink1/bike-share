class Station < ActiveRecord::Base
  belongs_to :city
  belongs_to :dock_count
  belongs_to :installation_date
  validates  :name, presence: true
  validates  :city, presence: true
  validates  :dock_count, presence: true
  validates  :installation_date, presence: true

  def self.average_bikes

  end
end

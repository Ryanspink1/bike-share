class InstallationDate < ActiveRecord::Base
  has_many  :stations
  validates :installation_date, presence: true
end
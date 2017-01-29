class DockCount < ActiveRecord::Base
  has_many  :stations
  validates :dock_number, presence: true, uniqueness: true
end
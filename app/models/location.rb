class Location < ActiveRecord::Base
  belongs_to :project
  geocoded_by :address
  after_validation :geocode
  #validates :address, presence: true
  #validates :project_id, presence: true
end

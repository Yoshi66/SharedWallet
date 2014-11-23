class Project < ActiveRecord::Base
  has_many :locations, dependent: :destroy
  belongs_to :user
  #validates :state_code
  #validates :country_caode
end

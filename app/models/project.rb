class Project < ActiveRecord::Base
  has_many :locations, dependent: :destroy
  belongs_to :user
  validates :state_code, presence: true
  validates :country_code, presence: true
  validates :content, presence: true
end

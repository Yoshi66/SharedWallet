class Project < ActiveRecord::Base
  has_many :locations, dependent: :destroy
  belongs_to :user
  validates :content, length: {maximum: 140}
end

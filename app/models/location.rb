class Location < ActiveRecord::Base
  belongs_to :project
  geocoded_by :address
  after_validation :geocode

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }

  # ファイルの拡張子を指定（これがないとエラーが発生する）
   validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  #validates :address, presence: true
  #validates :project_id, presence: true
end

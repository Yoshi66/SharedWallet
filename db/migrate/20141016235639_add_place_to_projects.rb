class AddPlaceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :place, :string
  end
end

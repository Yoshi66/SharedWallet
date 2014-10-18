class AddProjectidToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :project_id, :integer
    add_index :locations, :project_id
  end
end

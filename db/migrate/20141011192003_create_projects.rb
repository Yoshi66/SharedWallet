class CreateProjects < ActiveRecord::Migration
  def change
    drop_table :projects
    create_table :projects do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end

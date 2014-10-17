class DropTableSuser < ActiveRecord::Migration
  def change
     drop_table :susers
  end
end

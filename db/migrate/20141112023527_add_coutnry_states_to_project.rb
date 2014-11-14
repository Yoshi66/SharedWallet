class AddCoutnryStatesToProject < ActiveRecord::Migration
  def change
    add_column :projects, :country_code, :string
    add_column :projects, :state_code, :string
  end
end

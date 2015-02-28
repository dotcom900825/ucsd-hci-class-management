class AddVisibleFieldToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :visible, :boolean, :default=>true
  end
end

class AddTeambasedFieldToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :team_based, :boolean, :default=>false
  end
end

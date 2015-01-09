class AddWaitListStatToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wait_listed, :boolean, :default=>false
  end
end

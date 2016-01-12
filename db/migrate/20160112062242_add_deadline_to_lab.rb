class AddDeadlineToLab < ActiveRecord::Migration
  def change
    add_column :labs, :deadline, :datetime
  end
end

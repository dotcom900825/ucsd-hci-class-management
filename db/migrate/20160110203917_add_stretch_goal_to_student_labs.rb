class AddStretchGoalToStudentLabs < ActiveRecord::Migration
  def change
    add_column :student_labs, :stretch_goal, :boolean, default: false
  end
end

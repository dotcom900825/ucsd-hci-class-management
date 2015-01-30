class AddUniqIndexForStudentLabs < ActiveRecord::Migration
  def change
    add_index :student_labs, [:student_id, :lab_id], :unique => true
  end
end

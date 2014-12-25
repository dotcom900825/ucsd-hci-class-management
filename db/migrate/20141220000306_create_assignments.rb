class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.text :description
      t.date :due_time

      t.timestamps
    end
  end
end

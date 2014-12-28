class CreateRubricFields < ActiveRecord::Migration
  def change
    create_table :rubric_fields do |t|
      t.string :name
      t.integer :assignment_id
      t.timestamps
    end
  end
end

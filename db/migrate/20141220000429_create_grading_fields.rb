class CreateGradingFields < ActiveRecord::Migration
  def change
    create_table :grading_fields do |t|
      t.string :name
      t.integer :category
      t.text :comment
      t.integer :rubric_id
      t.timestamps
    end
  end
end

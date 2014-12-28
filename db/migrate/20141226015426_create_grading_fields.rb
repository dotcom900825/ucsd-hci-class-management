class CreateGradingFields < ActiveRecord::Migration
  def change
    create_table :grading_fields do |t|
      t.string :name
      t.integer :score
      t.text :comment
      t.integer :submission_id
      t.timestamps
    end
  end
end

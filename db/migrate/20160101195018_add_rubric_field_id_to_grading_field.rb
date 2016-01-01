class AddRubricFieldIdToGradingField < ActiveRecord::Migration
  def change
    add_column :grading_fields, :rubric_field_id, :integer
  end
end

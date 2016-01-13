class AddDescriptionToRubricField < ActiveRecord::Migration
  def change
    add_column :rubric_fields, :nope, :text
    add_column :rubric_fields, :weak, :text
    add_column :rubric_fields, :proficient, :text
    add_column :rubric_fields, :mastery, :text
    add_column :rubric_fields, :points, :integer
  end
end

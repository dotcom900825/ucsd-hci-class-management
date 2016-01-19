class AddSelectedRubricItemsColumnToGradingField < ActiveRecord::Migration
  def change
    add_column :grading_fields, :selected_rubric_items, :string, :default=>"[]"
  end
end

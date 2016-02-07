class AddExtraCreditColumnToRubricFieldItems < ActiveRecord::Migration
  def change
  	add_column :rubric_field_items, :extra_credit, :boolean, :default=>false
  end
end

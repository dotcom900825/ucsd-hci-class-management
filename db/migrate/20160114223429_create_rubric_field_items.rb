class CreateRubricFieldItems < ActiveRecord::Migration
  def change
    create_table :rubric_field_items do |t|
      t.string :name
      t.integer :rubric_field_id
      t.integer :point, default: 1
      t.integer :item_position
      t.timestamps
    end
  end
end

class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :name
      t.integer :ta_id

      t.timestamps
    end
  end
end

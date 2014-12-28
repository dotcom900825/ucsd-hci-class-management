class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :location
      t.string :theme
      t.string :time
      t.integer :ta_id


      t.timestamps
    end
  end
end

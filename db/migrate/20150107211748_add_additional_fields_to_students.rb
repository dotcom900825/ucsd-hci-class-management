class AddAdditionalFieldsToStudents < ActiveRecord::Migration
  def change
    add_column :users, :college, :string
    add_column :users, :year, :string
    add_column :users, :major, :string
  end
end

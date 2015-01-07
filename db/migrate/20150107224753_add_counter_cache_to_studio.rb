class AddCounterCacheToStudio < ActiveRecord::Migration
  def change
    add_column :studios, :students_count, :integer, :default=>0
  end
end

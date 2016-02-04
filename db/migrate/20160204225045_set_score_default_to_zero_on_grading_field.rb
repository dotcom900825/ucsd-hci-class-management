class SetScoreDefaultToZeroOnGradingField < ActiveRecord::Migration
  def change
  	change_column :grading_fields, :score, :integer, :default=>0
  end
end

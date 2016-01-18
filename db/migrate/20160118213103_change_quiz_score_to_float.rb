class ChangeQuizScoreToFloat < ActiveRecord::Migration
  def change
    change_column :student_quizzes, :score, :float, :default=>0
  end
end

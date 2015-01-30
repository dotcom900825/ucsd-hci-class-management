class CreateStudentQuizzes < ActiveRecord::Migration
  def change
    create_table :student_quizzes do |t|
      t.integer :student_id
      t.integer :quiz_id
      t.integer :score
      t.timestamps
      t.index [:student_id, :quiz_id], :unique=>true
    end


  end
end

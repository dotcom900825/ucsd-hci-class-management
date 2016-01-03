# == Schema Information
#
# Table name: student_quizzes
#
#  id         :integer          not null, primary key
#  student_id :integer
#  quiz_id    :integer
#  score      :integer
#  created_at :datetime
#  updated_at :datetime
#

class StudentQuiz < ActiveRecord::Base
  belongs_to :student
  belongs_to :quiz
end

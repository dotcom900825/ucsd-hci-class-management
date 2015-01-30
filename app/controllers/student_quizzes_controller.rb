class StudentQuizzesController < ApplicationController
  def index
    @student_quizzes = current_user.student_quizzes
  end
end
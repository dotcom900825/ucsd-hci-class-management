class StudentQuizzesController < ApplicationController
  before_filter :require_login

  def index
    @student_quizzes = current_user.student_quizzes
  end
end
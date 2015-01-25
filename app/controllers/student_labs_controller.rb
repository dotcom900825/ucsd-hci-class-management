class StudentLabsController < ApplicationController
  def index
    @student_labs = current_user.student_labs
  end
end
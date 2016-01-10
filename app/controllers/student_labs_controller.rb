class StudentLabsController < ApplicationController
  before_filter :require_login

  def index
    @student_labs = current_user.student_labs
  end

  def create
    @student_lab = StudentLab.create(student_lab_params.merge(complete: true))
    flash[:success] = "Submission success"
    redirect_to student_labs_path
  end

  private
  def student_lab_params
    params.require(:student_lab).permit(:lab_id, :github_url, :complete)
  end
end
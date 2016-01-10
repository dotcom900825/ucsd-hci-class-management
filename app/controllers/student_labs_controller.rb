class StudentLabsController < ApplicationController
  before_filter :require_login

  def index
    @student_labs = current_user.student_labs
    @ignorables = []
    @student_labs.each do |student_lab|
      @ignorables << student_lab.lab_id if student_lab.complete
    end
  end

  def create
    @student_lab = current_user.student_labs.create(student_lab_params.merge(complete: true))
    flash[:success] = "Submission success"
    redirect_to student_labs_path
  end

  private
  def student_lab_params
    params.require(:student_lab).permit(:lab_id, :github_link, :complete, :stretch_goal)
  end
end
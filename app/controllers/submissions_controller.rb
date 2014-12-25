class SubmissionsController < ApplicationController
  def create
    @submission = Submission.create(submission_params)
    flash[:success] = "Submission success"
    redirect_to assignment_path(@submission.assignment)
  end

  private
  def submission_params
    params.require(:submission).permit(:attachment, :assignment_id, :student_id)
  end

end
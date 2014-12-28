class SubmissionsController < ApplicationController
  def index
    @assignment = Assignment.find(params[:assignment_id])
    @studio = Studio.find(params[:studio_id])
    @submissions = Submission.where(:assignment=>@assignment).joins(:student).where(:users=>{studio_id: @studio.id})
  end

  def assignments
    @assignments = Assignment.all.order("created_at ASC")
    @studios = current_user.studios
  end

  def create
    @submission = Submission.create(submission_params)
    flash[:success] = "Submission success"
    redirect_to assignment_path(@submission.assignment)
  end

  def update
    @submission = Submission.find(params[:id])
    @submission.update(submission_params)
    flash[:success] = "Update success"
    redirect_to :back
  end

  def edit
    @assignment = Assignment.find(params[:assignment_id])
    @submission = Submission.find(params[:id])
  end

  private
  def submission_params
    params.require(:submission).permit(:attachment, :assignment_id, :student_id, :grading_fields_attributes=>[:score, :comment])
  end

end
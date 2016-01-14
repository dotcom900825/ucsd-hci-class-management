class StudentLabsController < ApplicationController
  before_filter :require_login

  def index
    @student_labs = current_user.student_labs
    @hidden_labs = []
    Lab.all.each do |lab|
      @hidden_labs << lab.id if lab.deadline.nil? || Time.now > lab.deadline
    end
  end

  def create
    if Time.now > Lab.find(student_lab_params[:lab_id]).deadline
      flash[:error] = "Your submission has passed lab's due date."
      redirect_to student_labs_path
    end
    @student_lab = current_user.student_labs.find_by(:lab_id=>student_lab_params[:lab_id])
    if @student_lab.present?
      @student_lab.update(student_lab_params.merge(complete: true))
    else
      @student_lab = current_user.student_labs.create(student_lab_params.merge(complete: true))
    end
    flash[:success] = "Submission success"
    redirect_to student_labs_path
  end

  private
  def student_lab_params
    params.require(:student_lab).permit(:lab_id, :github_link, :heroku_link, :complete, :stretch_goal)
  end
end
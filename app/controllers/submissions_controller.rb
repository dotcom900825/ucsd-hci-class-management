class SubmissionsController < ApplicationController
  def index
    @assignment = Assignment.find(params[:assignment_id])
    @studio = Studio.find(params[:studio_id])
    @submissions = Submission.where(:assignment=>@assignment).joins(:student).where(:users=>{studio_id: @studio.id}).order("users.team_id ASC, submissions.created_at ASC")
    @not_submitted_students = Student.find (@studio.students.all.pluck(:id) - @studio.students.joins("left outer join submissions on submissions.student_id = users.id").where(:submissions=>{:assignment=>@assignment}).pluck(:id))
  end

  def assignments
    if current_user
      @assignments = Assignment.all.order("created_at ASC")
      @studios = current_user.studios
    else
      flash[:alert] = "Login in required"
      redirect_to root_path
    end
  end

  def create
    @submission = Submission.create(submission_params)
    flash[:success] = "Submission success"
    redirect_to assignment_path(@submission.assignment)
  end

  def update
    @submission = Submission.find(params[:id])
    @submission.grading_fields.update_all(:selected_rubric_items=>nil)
    @submission.update(submission_params)

    flash[:success] = "Update success"
    redirect_to :back
  end

  def edit
    @assignment = Assignment.find(params[:assignment_id])
    @studio = Studio.find(params[:studio_id])
    @submission = Submission.find(params[:id])
  end

  private
  def submission_params
    params.require(:submission).permit(:self_assessment_grade, :comment, :ta_grade, :sa_points, :final_grade, :attachment, :assignment_id, :student_id, :grading_fields_attributes=>[:id, :score, :comment, :rubric_field_id, selected_rubric_items: []])
  end
end
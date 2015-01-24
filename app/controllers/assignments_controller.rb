require 'csv'

class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :download_score, :grading_overview, :submissions_within]
  before_action :check_permission, only: [:grading_overview, :download_score]
  # GET /assignments
  # GET /assignments.json
  def index
    if current_user.present?
      @assignments = Assignment.all.order("created_at ASC")
      @submissions = current_user.submissions.all.includes(:assignment)
    else
      flash[:alert] = "Login in required"
      redirect_to root_path
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    if current_user.present?
      @submission = current_user.submissions.find_by(:assignment=>@assignment)
      @submission = current_user.submissions.new(:assignment=>@assignment) unless @submission.present?
    else
      flash[:alert] = "Login in required"
      redirect_to root_path
    end
  end

  def download_score
    @submissions = Submission.all.where(:assignment_id=>@assignment.id)
    respond_to do |format|
      format.csv {
        headers['Content-Disposition'] = "attachment; filename=\"user-list\""
        headers['Content-Type'] ||= 'text/csv'
      }
    end
  end

  def grading_overview
    @submissions = @assignment.submissions.where("final_grade > 0")
    @student_with_submission_but_no_final_grade = @assignment.submissions.where("final_grade = 0")
    @students_missing_submission = Student.find (Student.all.pluck(:id) - Student.joins("left outer join submissions on submissions.student_id = users.id").where(:submissions=>{:assignment=>@assignment}).pluck(:id))
  end

  def see_submissions
    if current_user.present?
      @assignments = Assignment.all.order("created_at ASC")
      @submissions = current_user.submissions.all.includes(:assignment)
    else
      flash[:alert] = "Login in required"
      redirect_to root_path
    end
  end

  def submissions_within
    @studio = Studio.find(params[:studio_id])
    @submissions = @assignment.submissions.joins(:student).where(:users=>{:studio_id=>@studio.id}).where("final_grade > 0")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def check_permission
      if current_user && current_user.is_ta?
        flash[:notice] = "Permission denied"
        redirect_to root_url and return
      end
    end
end

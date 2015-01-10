require 'csv'

class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :download_score, :grading_overview]

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
    @submissions = @assignment.submissions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end
end

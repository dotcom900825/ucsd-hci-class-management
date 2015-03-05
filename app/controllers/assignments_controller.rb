require 'csv'

class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :download_score, :grading_overview, :submissions_within, :score_overview]
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

  def score_overview
    @ta_hash = {}
    @final_hash = {}

    Ta.all.each do |ta|
      studios = ta.studios.pluck(:id)
      avg = Submission.where(:assignment=>@assignment).joins(:student).where(:users=>{:studio_id=>studios}).average(:final_grade)
      final_avg = Submission.where(:assignment=>@assignment).joins(:student).where(:users=>{:studio_id=>studios}).average(:ta_grade)
      @ta_hash[ta.name] = avg
      @final_hash[ta.name] = final_avg
    end

    gon.ta_keys = @ta_hash.keys
    gon.final_values = @final_hash.values
    gon.ta_values = @final_hash.values

    respond_to do |format|
      format.html
      format.json
    end
  end

  def per_rubric_overview
    @assignment = Assignment.find params[:id]

    @array = []
    Ta.all.each do |ta|
      ta.studios.each do |studio|
        submissions = Submission.where(:assignment=>@assignment).joins(:student).where(:users=>{studio_id: studio.id})
        
        hash = {"info" => "#{ta.name} #{studio.time}"}
        (0..@assignment.rubric_fields.size - 1).each do |index|
          hash[@assignment.rubric_fields[index].name] = 0
        end

        submissions.each do |submission|
          (0..@assignment.rubric_fields.size - 1).each do |index|
            hash[@assignment.rubric_fields[index].name] += submission.grading_fields[index].score.to_i if submission.grading_fields[index].present?
          end
        end

        (0..@assignment.rubric_fields.size - 1).each do |index|
          hash[@assignment.rubric_fields[index].name] = hash[@assignment.rubric_fields[index].name] / submissions.size.to_f if submissions.size > 0
        end


        @array.push hash
      end
    end

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

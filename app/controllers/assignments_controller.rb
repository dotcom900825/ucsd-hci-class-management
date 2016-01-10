require 'csv'
require "descriptive_statistics"

class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :download_score, :grading_overview, :submissions_within, :score_overview]
  before_action :check_permission, only: [:grading_overview, :download_score]
  # GET /assignments
  # GET /assignments.json
  def index
    if current_user.present?
      @assignments = Assignment.all.order("created_at ASC")
      # @submissions = current_user.submissions.all.includes(:assignment)
      @submissions = {}
      @assignments.each do |assignment|
        submission = Submission.where(student: current_user, assignment: assignment).order(:updated_at).last
        submission = find_team_submission(assignment) if submission.nil?
        @submissions[assignment] = submission
      end
    else
      flash[:alert] = "Login in required"
      redirect_to root_path
    end
  end

  def api_data
    result = {}
    @assignment = Assignment.find(params[:id])
    result[:assignment_name] = @assignment.name
    result[:criteria] = []
    @assignment.rubric_fields.each do |rubric|
      result[:criteria] << {:title=>rubric.name}
    end
    render json: result
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    if current_user.present?
      @submission = current_user.submissions.find_by(:assignment=>@assignment)
      @submission = find_team_submission(@assignment) if @submission.nil?
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
        total = 0
        submissions = Submission.where(:assignment=>@assignment).joins(:student).where(:users=>{studio_id: studio.id})
        
        hash = {"info" => "#{ta.name} #{studio.time}"}
        (0..@assignment.rubric_fields.size - 1).each do |index|
          hash[@assignment.rubric_fields[index].name] = 0
        end

        submissions.each do |submission|
          (0..@assignment.rubric_fields.size - 1).each do |index|
            hash[@assignment.rubric_fields[index].name] += submission.grading_fields[index].score.to_i if submission.grading_fields[index].present?
          end

          total += submission.ta_grade
        end

        hash["ta_grade"] = (total / submissions.size.to_f).round(2)

        (0..@assignment.rubric_fields.size - 1).each do |index|
          hash[@assignment.rubric_fields[index].name] = (hash[@assignment.rubric_fields[index].name] / submissions.size.to_f).round(2) if submissions.size > 0
        end


        @array.push hash
      end
    end

    hash = {"std" => "Standard deviation"}
    (0..@assignment.rubric_fields.size - 1).each do |index|
      sum = []
      @array.each do |ta_info|
        sum << ta_info[@assignment.rubric_fields[index].name] if ta_info[@assignment.rubric_fields[index].name] > 0
      end

      hash[@assignment.rubric_fields[index].name] = sum.standard_deviation
    end

    sum = []
    @array.each do |ta_info|
      sum << ta_info["ta_grade"] if ta_info["ta_grade"] > 0
    end
    hash["ta_grade"] = sum.standard_deviation
    @array.push hash

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

    def find_team_submission(assignment)
      return nil unless current_user.team && assignment.team_based
      Submission.where(student: current_user.team.students, assignment: assignment).order(:final_grade).last
    end
end

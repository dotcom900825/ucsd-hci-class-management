class StudentLabsController < ApplicationController
  before_filter :require_login

  def index
    # puts "REQUEST: #{request.remote_ip}"
    @student_labs = current_user.student_labs
    @hidden_labs = []
    @remote_ip = request.remote_ip
    Lab.all.each do |lab|
      @hidden_labs << lab.id if lab.deadline.nil? || Time.now > lab.deadline
    end
  end

  def create
    if Time.now > Lab.find(student_lab_params[:lab_id]).deadline
      flash[:error] = "Your submission has passed lab's due date."
      redirect_to student_labs_path
      return
    end
    # puts "REQUEST: #{request.remote_ip}"
    @student_lab = current_user.student_labs.find_by(:lab_id=>student_lab_params[:lab_id])
    if @student_lab.present?
      @student_lab.update(student_lab_params.merge(complete: true))
    else
      @student_lab = current_user.student_labs.create(student_lab_params.merge(complete: true))
    end
    @student_lab.update(:ip=>request.remote_ip)
    flash[:success] = "Lab Submission success. Your IP was #{request.remote_ip}."
    redirect_to student_labs_path
  end

  private
  def student_lab_params
    params.require(:student_lab).permit(:lab_id, :github_link, :heroku_link, :complete, :stretch_goal, :certified)
  end
end
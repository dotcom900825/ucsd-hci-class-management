class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to new_user_session_path, notice: "Create success"}
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
    redirect_to assignments_path unless Time.now <= $studio_due
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    @student.update_attribute(:studio_id, params[:student][:studio_id])
    flash[:success] = "Studio update success"
    redirect_to assignments_path
    # redirect_to root_path
  end

  private

  def student_params
    params.require(:student).permit(:email, :password, :password_confirmation, :pid, :name, :studio_id)
  end
end
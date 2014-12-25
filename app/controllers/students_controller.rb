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

  private

  def student_params
    params.require(:student).permit(:email, :password, :password_confirmation, :pid, :name)
  end
end
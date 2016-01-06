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
    unless Time.now <= STUDIO_DUE
      flash[:notice] = "Studio signup is due."
      redirect_to root_path
    end
    @student = Student.find(params[:id])
  end

  def update
    count = Studio.find(params[:student][:studio_id]).students_count
    if count >= 0 && count < STUDIO_CAP
      @student = Student.find(params[:id])
      @student.update_attribute(:studio_id, params[:student][:studio_id])
      flash[:success] = "Studio update success"
      redirect_to root_path
    else
      flash[:error] = "The studio is full. Please try to enroll in another section"
      redirect_to :back # refresh the page
    end
  end

  private

  def student_params
    params.require(:student).permit(:email, :password, :password_confirmation, :pid, :name, :studio_id)
  end
end
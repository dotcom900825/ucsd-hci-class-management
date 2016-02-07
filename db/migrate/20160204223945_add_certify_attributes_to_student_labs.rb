class AddCertifyAttributesToStudentLabs < ActiveRecord::Migration
  def change
  	add_column :student_labs, :certified, :boolean, default: false
  	add_column :student_labs, :ip, :string
  end
end

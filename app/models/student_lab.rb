# == Schema Information
#
# Table name: student_labs
#
#  id         :integer          not null, primary key
#  student_id :integer
#  lab_id     :integer
#  complete   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class StudentLab < ActiveRecord::Base
  belongs_to :student
  belongs_to :lab
end

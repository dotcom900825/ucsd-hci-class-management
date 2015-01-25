class StudentLab < ActiveRecord::Base
  belongs_to :student
  belongs_to :lab
end

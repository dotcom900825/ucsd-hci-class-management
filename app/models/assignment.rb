class Assignment < ActiveRecord::Base
  has_many :submissions
  has_many :rubric_fields
end

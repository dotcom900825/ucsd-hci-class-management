class Submission < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment

  has_many :grading_fields, :dependent => :destroy
  accepts_nested_attributes_for :grading_fields

  has_attached_file :attachment
  do_not_validate_attachment_file_type :attachment
end

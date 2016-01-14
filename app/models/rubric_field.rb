# == Schema Information
#
# Table name: rubric_fields
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  assignment_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class RubricField < ActiveRecord::Base
  belongs_to :assignment
  has_many :rubric_field_items
end

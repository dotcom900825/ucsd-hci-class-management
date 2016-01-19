# == Schema Information
#
# Table name: grading_fields
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  score           :integer
#  comment         :text
#  submission_id   :integer
#  created_at      :datetime
#  updated_at      :datetime
#  rubric_field_id :integer
#

class GradingField < ActiveRecord::Base
  belongs_to :submission
  belongs_to :rubric_field
  default_scope { order(:id) }

  serialize :selected_rubric_items
end

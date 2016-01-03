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

require 'rails_helper'

RSpec.describe GradingField, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

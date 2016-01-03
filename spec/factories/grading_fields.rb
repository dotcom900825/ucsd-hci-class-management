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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :grading_field do
  end
end

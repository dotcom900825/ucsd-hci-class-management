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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rubric_fields do
  end
end

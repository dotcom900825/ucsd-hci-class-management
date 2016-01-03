# == Schema Information
#
# Table name: studios
#
#  id             :integer          not null, primary key
#  location       :string(255)
#  theme          :string(255)
#  time           :string(255)
#  ta_id          :integer
#  created_at     :datetime
#  updated_at     :datetime
#  section_num    :string(255)
#  students_count :integer          default(0)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :studio do
  end
end

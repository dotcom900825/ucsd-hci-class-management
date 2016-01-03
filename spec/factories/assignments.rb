# == Schema Information
#
# Table name: assignments
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  due_time    :date
#  created_at  :datetime
#  updated_at  :datetime
#  visible     :boolean          default(TRUE)
#  team_based  :boolean          default(FALSE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    name 'Design Thinking'
    team_based 'false'
    due_time Time.zone.local(2016, 1, 8)
  end
end

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

class Assignment < ActiveRecord::Base
  has_many :submissions
  has_many :rubric_fields
end

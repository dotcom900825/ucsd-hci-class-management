# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  studio_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  belongs_to :studio
  has_many :students
end

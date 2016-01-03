# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  name             :string(255)      not null
#  type             :string(255)
#  pid              :string(255)      not null
#  crypted_password :string(255)      not null
#  salt             :string(255)      not null
#  studio_id        :integer
#  team_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  college          :string(255)
#  year             :string(255)
#  major            :string(255)
#  wait_listed      :boolean          default(FALSE)
#

class Student < User
  belongs_to :studio, counter_cache: true
  belongs_to :team

  has_many :submissions, dependent: :destroy

  has_many :labs, through: :student_labs
  has_many :student_labs

  has_many :quizzes, through: :student_quizzes
  has_many :student_quizzes
end

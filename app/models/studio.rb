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

class Studio < ActiveRecord::Base
  scope :have_slot, -> { where('students_count < ?', STUDIO_CAP) }

  belongs_to :ta
  has_many :students

  def studio_name
    "#{theme} | #{ta.name} | #{location} | #{time}"
  end

  def count_submission(assignment)
    count = Submission.where(assignment: assignment).joins(:student)
            .where(users: { studio_id: id }).count
    count
  end

  def name
    "#{theme} | #{location} | #{time}"
  end

  def short_name
    "#{ta.name} | #{theme}"
  end
end

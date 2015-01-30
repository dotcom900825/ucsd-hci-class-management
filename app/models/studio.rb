class Studio < ActiveRecord::Base

  scope :have_slot, -> {where("students_count < 18")}

  belongs_to :ta
  has_many :students
  
  def studio_name
    "#{theme} | #{ta.name} | #{location} | #{time}"
  end

  def count_submission(assignment)
    count = Submission.where(:assignment=>assignment).joins(:student).where(:users=>{studio_id: self.id}).count
    return count
  end

  def name
    "#{theme} | #{location} | #{time}"
  end

  def short_name
    "#{ta.name} | #{theme}"
  end
end

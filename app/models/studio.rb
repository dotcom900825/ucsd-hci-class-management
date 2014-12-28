class Studio < ActiveRecord::Base
  belongs_to :ta
  has_many :students
  
  def name
    "#{theme} | #{ta.name} | #{location} | #{time}"
  end

  def count_submission(assignment)
    count = Submission.where(:assignment=>assignment).joins(:student).where(:users=>{studio_id: self.id}).count
    return count
  end
end

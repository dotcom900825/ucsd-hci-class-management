class Student < User
  belongs_to :studio
  belongs_to :team

  has_many :submissions
  
end
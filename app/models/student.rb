class Student < User
  belongs_to :studio, :counter_cache => true
  belongs_to :team

  has_many :submissions, :dependent => :destroy

  has_many :labs, through: :student_labs
  has_many :student_labs

  has_many :quizzes, through: :student_quizzes
  has_many :student_quizzes

  
end
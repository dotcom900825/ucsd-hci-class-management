class Student < User
  belongs_to :studio, :counter_cache => true
  belongs_to :team

  has_many :submissions, :dependent => :destroy
  
end
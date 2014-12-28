class Team < ActiveRecord::Base
  belongs_to :studio
  has_many :students
  
end

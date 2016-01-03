# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Quiz < ActiveRecord::Base

end

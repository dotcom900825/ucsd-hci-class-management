# == Schema Information
#
# Table name: submissions
#
#  id                      :integer          not null, primary key
#  student_id              :integer
#  assignment_id           :integer
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  self_assessment_grade   :integer          default(0)
#  ta_grade                :integer          default(0)
#  sa_points               :integer          default(0)
#  final_grade             :integer          default(0)
#

require 'rails_helper'

RSpec.describe Submission, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

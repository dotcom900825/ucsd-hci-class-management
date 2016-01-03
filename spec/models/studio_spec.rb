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

require 'rails_helper'

RSpec.describe Studio, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

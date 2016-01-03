# == Schema Information
#
# Table name: assignments
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  due_time    :date
#  created_at  :datetime
#  updated_at  :datetime
#  visible     :boolean          default(TRUE)
#  team_based  :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Assignment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

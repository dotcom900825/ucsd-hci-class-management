# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  name             :string(255)      not null
#  type             :string(255)
#  pid              :string(255)      not null
#  crypted_password :string(255)      not null
#  salt             :string(255)      not null
#  studio_id        :integer
#  team_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#  college          :string(255)
#  year             :string(255)
#  major            :string(255)
#  wait_listed      :boolean          default(FALSE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  end
end

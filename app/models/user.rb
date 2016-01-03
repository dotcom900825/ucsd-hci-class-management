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

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, presence:true, length: { minimum: 6 }, confirmation: true, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  validates :email, uniqueness: true

  USER_TYPE = { :student => 'Student', :ta => 'Ta' }


  USER_TYPE.each do |name, value|
    define_method "is_#{name}?" do type == value end
  end

  private
  def password_required?
    new_record? || password.present?
  end

end

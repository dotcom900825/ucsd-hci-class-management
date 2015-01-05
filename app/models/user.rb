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

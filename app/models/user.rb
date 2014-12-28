class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  USER_TYPE = { :student => 'Student', :ta => 'Ta' }


  USER_TYPE.each do |name, value|
    define_method "is_#{name}?" do type == value end
  end

end

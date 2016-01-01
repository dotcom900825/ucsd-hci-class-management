password = 'ucsd-hci-170'

task :load_tas => :environment do
  Ta.create(:email=>"tngoon@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Tricia Ngoon")
  Ta.create(:email=>"rgougele@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Robert J Gougelet")
  Ta.create(:email=>"ykotturi@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Yasmine Kotturi ")
  Ta.create(:email=>"kyungyullim@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Kyung yul Lim")
  Ta.create(:email=>"nzhussain@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Nida Hussain")
  Ta.create(:email=>"jeqin@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Jesse Qin")
  Ta.create(:email=>"bchinh@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Bonnie Chinh")
  Ta.create(:email=>"acrule@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Adam Rule")
  Ta.create(:email=>"bsoe@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Brian Soe")
  Ta.create(:email=>"srk@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Scott Klemmer")
end
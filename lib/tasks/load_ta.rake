password = 'ucsd-hci-170'

task :load_tas => :environment do
  Ta.create(:email=>"vipandey@eng.ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Vineet Pandey")
  Ta.create(:email=>"rgougele@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Robert J Gougelet")
  Ta.create(:email=>"axl002@ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Alvin Li")
  Ta.create(:email=>"pdesai@eng.ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Purvi Desai")
  Ta.create(:email=>"kyl063@eng.ucsd.edu", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Kevin Lim")
  Ta.create(:email=>"adammekrut@gmail.com", :pid=>"none", :password=>password, :password_confirmation=>password, :name=>"Adam Mekrut")
end
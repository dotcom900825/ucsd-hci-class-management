task :load_tas => :environment do
  Ta.create(:email=>"vipandey@eng.ucsd.edu", :pid=>"none", :password=>"hci-170-partners", :password_confirmation=>"hci-170-partners", :name=>"Vineet Pandey")
  Ta.create(:email=>"rgougele@ucsd.edu", :pid=>"none", :password=>"hci-170-partners", :password_confirmation=>"hci-170-partners", :name=>"Robert J Gougelet")
  Ta.create(:email=>"axl002@ucsd.edu", :pid=>"none", :password=>"hci-170-partners", :password_confirmation=>"hci-170-partners", :name=>"Alvin Li")
  Ta.create(:email=>"pdesai@eng.ucsd.edu", :pid=>"none", :password=>"hci-170-partners", :password_confirmation=>"hci-170-partners", :name=>"Purvi Desai")
  Ta.create(:email=>"kyl063@eng.ucsd.edu", :pid=>"none", :password=>"hci-170-partners", :password_confirmation=>"hci-170-partners", :name=>"Kevin Lim")
  Ta.create(:email=>"adammekrut@gmail.com", :pid=>"none", :password=>"hci-170-partners", :password_confirmation=>"hci-170-partners", :name=>"Adam Mekrut")
end
task :load_tas => :environment do
  Ta.create(:email=>"y2xia1@eng.ucsd.edu", :pid=>"none", :password=>"hci-170-partners", :password_confirmation=>"hci-170-partners", :name=>"Yu Xia")
end
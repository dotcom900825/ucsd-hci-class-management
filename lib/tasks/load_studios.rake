task :load_studios => :environment do
  Studio.create(:theme=>"Community", :location=>"Moxie Center B210", :time=>"Friday 2:30PM", :ta=>Ta.find_by(:name=>"Yu Xia"))

end
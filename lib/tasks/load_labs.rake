task :load_labs => :environment do
  Lab.create(:name=>"Lab 1: Source Control")
  Lab.create(:name=>"Lab 2: Styling")
  Lab.create(:name=>"Lab 3: Client-Side Interactivity")
  Lab.create(:name=>"Lab 4: Servers")
  Lab.create(:name=>"Lab 5: Putting it together")
  Lab.create(:name=>"Lab 6: AJAX")
  Lab.create(:name=>"Lab 7: Databases")
  Lab.create(:name=>"Lab 8: Analytics")
end
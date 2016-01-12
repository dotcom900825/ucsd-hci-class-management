task :add_lab_deadlines => :environment do
  lab_names = ["Lab 1: Source Control", "Lab 2: Styling", "Lab 3: Client-Side Interactivity", "Lab 4: Servers", "Lab 5: Putting it together", "Lab 6: AJAX", "Lab 7: Databases", "Lab 8: Analytics"]
  deadlines = ["2016/01/07 14:00:00", "2016/01/14 14:00:00", "2016/01/21 14:00:00", "2016/01/28 14:00:00", "2016/02/04 14:00:00", "2016/02/11 14:00:00", "2016/02/18 14:00:00", "2016/02/25 14:00:00", "2016/03/03 14:00:00", "2016/03/11 14:00:00"]
  8.times.each do |i|
    time = Time.zone.parse(deadlines[i])
    Lab.find_by(:name=>lab_names[i]).update(:deadline=>time)
  end
end
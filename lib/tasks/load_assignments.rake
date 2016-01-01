task :load_assignments => :environment do
  Assignment.create(:name=>"Design Thinking", team_based: false, due_time: Time.zone.local(2016, 1, 8))
  Assignment.create(:name=>"Needfinding", team_based: false, due_time: Time.zone.local(2016, 1, 8))
  Assignment.create(:name=>"Prototyping", team_based: true, due_time: Time.zone.local(2016, 1, 15))
  Assignment.create(:name=>"Heuristic evaluation", team_based: false, due_time: Time.zone.local(2016, 1, 22))
  Assignment.create(:name=>"Skeleton and a plan", team_based: true, due_time: Time.zone.local(2016, 1, 29))
  Assignment.create(:name=>"Meat on the bones", team_based: true, due_time: Time.zone.local(2016, 2, 5))
  Assignment.create(:name=>"Ready for testing", team_based: true, due_time: Time.zone.local(2016, 2, 12))
  Assignment.create(:name=>"Test your prototype", team_based: true, due_time: Time.zone.local(2016, 2, 19))
  Assignment.create(:name=>"Results!", team_based: true, due_time: Time.zone.local(2016, 2, 26))
  Assignment.create(:name=>"Final Presentation", team_based: true, due_time: Time.zone.local(2016, 3, 4))

end
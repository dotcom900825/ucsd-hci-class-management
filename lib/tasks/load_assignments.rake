task :load_assignments => :environment do
  Assignment.create(:name=>"Waiting in Line")
  Assignment.create(:name=>"Needfinding")
  Assignment.create(:name=>"Prototyping")
  Assignment.create(:name=>"Heuristic evaluation")
  Assignment.create(:name=>"Skeleton and a plan")
  Assignment.create(:name=>"Meat on the bones")
  Assignment.create(:name=>"Ready for testing")
  Assignment.create(:name=>"Test your prototype")
  Assignment.create(:name=>"Results!")
  Assignment.create(:name=>"Final Presentation")

end
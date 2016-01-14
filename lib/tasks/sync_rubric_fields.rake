task :sync_rubric_fields, [:assignment] => :environment do |t, args|
  rubric_fields = Assignment.find(args[:assignment]).rubric_fields.order(:id)
  index = 0
  CSV.foreach(File.expand_path("../rubric_fields_#{args[:assignment]}.csv", __FILE__)) do |row|
    name = row[0].strip
    nope = row[1].strip
    weak = row[2].strip
    proficient = row[3].strip
    mastery = row[4].strip
    points = row[5].strip
    if index < rubric_fields.length
      rubric_fields[index].update(:name=>name, :nope=>nope, :weak=>weak, :proficient=>proficient, :mastery=>mastery, :points=>points.to_i)
    else
      rubric_fields.create(:name=>name, :nope=>nope, :weak=>weak, :proficient=>proficient, :mastery=>mastery, :points=>points.to_i)
    end
    index += 1
  end
end
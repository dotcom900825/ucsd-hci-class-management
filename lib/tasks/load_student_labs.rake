require "csv"

task :load_student_labs, [:lab] => :environment do |t, args|
  puts args
  CSV.foreach(File.expand_path("../student_lab_#{args[:lab]}.csv", __FILE__)) do |row|
    pid = row[0].strip
    github_link = row[1].strip
    stretch_goal = row[2].strip == "Yes" ? true : false
    student = Student.find_by(:pid=>pid)
    lab = Lab.find(args[:lab])
    submission = StudentLab.find_by(:student=>student, :lab=>lab)
    if submission
      submission.update(:complete=>true, :github_link=>github_link, :stretch_goal=>stretch_goal)
    else
      StudentLab.create(:student=>student, :lab=>lab, :complete=>true, :github_link=>github_link, :stretch_goal=>stretch_goal)
    end
  end
end


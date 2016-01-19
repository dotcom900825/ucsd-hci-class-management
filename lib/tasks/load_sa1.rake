require "csv"
task :load_sa1 => :environment do
  students_list = []
  CSV.foreach(File.expand_path("../sa1.csv", __FILE__)) do |row|
    pid = row[0].strip
    student = Student.find_by(:pid=>pid)
    if student.present?
      submission = student.submissions.find_by(:assignment_id=>1)
      submission.update(:sa_points=>1) if submission.present?
    end
  end
end
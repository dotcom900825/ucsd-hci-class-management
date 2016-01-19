require "csv"
task :load_sa, [:assignment] => :environment do |t, args|
  students_list = []
  CSV.foreach(File.expand_path("../sa#{args[:assignment]}.csv", __FILE__)) do |row|
    pid = row[0].strip
    sa_grade = row[1].to_i
    student = Student.find_by(:pid=>pid)
    if student.present?
      submission = student.submissions.find_by(:assignment_id=>args[:assignment].to_i)
      if submission.present?
        submission.self_assessment_grade = sa_grade
        if submission.final_grade > 0
          ta_grade = submission.ta_grade
          if (ta_grade - sa_grade).abs <= 2
            submission.sa_points = 1
            submission.final_grade = (ta_grade + sa_grade)/2
          else
            submission.sa_points = 0
            submission.final_grade = ta_grade
          end
        end
        submission.save
      end
    end
  end
end
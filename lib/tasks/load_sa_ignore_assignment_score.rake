require "csv"
task :load_sa_score, [:assignment] => :environment do |t, args|
  CSV.foreach(File.expand_path("../sa_scores_#{args[:assignment]}.csv", __FILE__)) do |row|
    pid = row[0].strip
    sa_points = row[1].strip.to_i
    student = Student.find_by(:pid=>pid)
    if student.present?
      submission = student.submissions.find_by(:assignment_id=>args[:assignment].to_i)
      if submission.nil? && student.team
        submission = Submission.where(student: student.team.students, :assignment_id=>args[:assignment].to_i).order(:final_grade).last
      end
      next if submission.nil?
      submission.update(:sa_points=>sa_points)
    end
  end
end
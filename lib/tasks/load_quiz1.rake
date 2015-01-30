require "csv"
task :load_quiz1 => :environment do
  hash = {}
  CSV.foreach(File.expand_path('../quiz1.csv', __FILE__)) do |row|
    pid = row[0]
    grade = row[1].to_i
    student = Student.find_by(:pid=>pid)
    if student 
      student.student_quizzes.create(:quiz_id=>1, :score=>grade)
    end
  end
end
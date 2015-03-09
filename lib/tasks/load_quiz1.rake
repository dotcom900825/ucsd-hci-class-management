require "csv"
task :load_quiz1 => :environment do
  hash = {}
  CSV.foreach(File.expand_path('../quiz1.csv', __FILE__)) do |row|
    pid = row[0]
    grade = row[1].to_i
    student = Student.find_by(:pid=>pid)
    if student 
      begin 
        student.student_quizzes.create(:quiz_id=>1, :score=>grade)
      rescue
        puts student.pid
      end
    end
  end
end

task :load_quiz2 => :environment do
  hash = {}
  CSV.foreach(File.expand_path('../quiz2.csv', __FILE__)) do |row|
    pid = row[0]
    grade = row[1].to_i
    student = Student.find_by(:pid=>pid)
    if student 
      begin 
        student.student_quizzes.create(:quiz_id=>2, :score=>grade)
      rescue
        puts student.pid
      end
    end
  end
end

task :load_quiz3 => :environment do
  hash = {}
  CSV.foreach(File.expand_path('../quiz3.csv', __FILE__)) do |row|
    pid = row[0]
    grade = row[1].to_i
    student = Student.find_by(:pid=>pid)
    if student 
      begin 
        student.student_quizzes.create(:quiz_id=>3, :score=>grade)
      rescue
        puts student.pid
      end
    end
  end
end
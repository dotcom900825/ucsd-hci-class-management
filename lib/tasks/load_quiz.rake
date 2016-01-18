require "csv"
task :load_quiz, [:quiz] => :environment do |t, args|
  hash = {}
  CSV.foreach(File.expand_path("../quiz#{args[:quiz]}.csv", __FILE__)) do |row|
    pid = row[0].to_s.strip
    email = row[1].to_s.strip
    score = row[2].to_s.strip.to_f
    student = Student.find_by(:pid=>pid)
    student = Student.find_by(:email=>email) if student.nil? # in case student mistyped their pid
    if student.present?
      if student.student_quizzes.find_by(:quiz_id=>args[:quiz].to_i).nil?
        student.student_quizzes.create(:quiz_id=>args[:quiz].to_i, :score=>score)
        puts "#{student.name} | #{score}"
      else
        student.student_quizzes.find_by(:quiz_id=>args[:quiz].to_i).update(:score=>score)
        puts "#{student.name} | #{score}"
      end
    end
  end
end

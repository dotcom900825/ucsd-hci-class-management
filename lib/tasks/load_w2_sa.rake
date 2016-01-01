require "csv"
task :load_w2_sa => :environment do
  students_list = []
  CSV.foreach(File.expand_path('../w2_sa.csv', __FILE__)) do |row|
    sa_grade = row[1].to_i
    student = Student.find_by(:pid=>row[0])
    if student
      sub = student.submissions.where(:assignment_id=>2).first
      if sub
        sub.self_assessment_grade = sa_grade
        if sub.final_grade > 0
          total = sub.grading_fields.pluck(:score).map {|ele| ele.to_i}.inject{|sum,x| sum + x }
          if (total - sa_grade).abs <= 2
            sub.sa_points = 2
          else
            #sub.final_grade = total
            sub.sa_points = 1
          end

          if (total - sa_grade).abs <= 1
            sub.final_grade = sa_grade 
          else
            sub.final_grade = total
          end

        end

        sub.save
      end
    end
  end

end
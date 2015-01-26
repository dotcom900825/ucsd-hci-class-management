require "csv"
task :load_w3_sa => :environment do
  hash = {}
  CSV.foreach(File.expand_path('../w3_sa.csv', __FILE__)) do |row|
    pid = row[0]
    sa_grade = row[1].to_i
    hash[sid] = sa_grade

    assignment = Assignment.find 3
    assignment.submissions.each do |sub|
      flag = false
      team = sub.student.team
      pids = team.students.pluck(:pid)
      pids.each do |s_pid|
        if hash[s_pid].present?
          if (sub.ta_grade - hash[s_pid]).abs <= 2
            sub.final_grade = hash[s_pid]
            sub.sa_points = 2
          else
            sub.sa_points = 1
          end
          sub.save
          flag = true
        else
          flat = false 
        end
      end
      puts sub.id if !flag
    end

  end

end
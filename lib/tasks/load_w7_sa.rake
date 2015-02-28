require "csv"
task :load_w7_sa => :environment do
  hash = {}
  CSV.foreach(File.expand_path('../w7_sa.csv', __FILE__)) do |row|
    pid = row[0]
    sa_grade = row[1].to_i
    hash[pid] = sa_grade
  end

  assignment = Assignment.find 7
  assignment.submissions.each do |sub|
    flag = false
    team = sub.student.team

    if team.present?
      pids = team.students.pluck(:pid)
      pids.each do |s_pid|
        if hash[s_pid].present?

          sub.self_assessment_grade = hash[s_pid]
          if sub.grading_fields.last.score.to_i > 0
            if (sub.ta_grade - 1 - hash[s_pid]).abs <= 2
              sub.sa_points = 2
            else
              sub.sa_points = 1
            end

            sub.final_grade = (hash[s_pid] + 1) if (sub.ta_grade - 1 - hash[s_pid]).abs <= 1

          else
            if (sub.ta_grade - hash[s_pid]).abs <= 2
              sub.sa_points = 2
            else
              sub.sa_points = 1
            end

            sub.final_grade = hash[s_pid] if (sub.ta_grade - hash[s_pid]).abs <= 1
          end

          sub.save
          flag = true
        else
          flat = false 
        end
      end
      puts sub.id if !flag
    else
      puts "student missing team #{sub.student.pid}"
    end
  end

end
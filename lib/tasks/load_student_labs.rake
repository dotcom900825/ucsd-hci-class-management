require "csv"

task :load_student_labs, [:lab] => :environment do |t, args|
  CSV.foreach(File.expand_path("../student_lab_#{args[:lab]}.csv", __FILE__)) do |row|
    pid = row[0]
    s = Student.where(pid: pid).first
    if pid && s.present?
      s.student_labs.create(lab_id: args[:lab]) if s.student_labs.where(lab_id: args[:lab]).count == 0
    end
  end
end


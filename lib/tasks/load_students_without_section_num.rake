require "csv"

class StudentObj
  attr_accessor :section_id, :pid, :name, :college, :major, :level, :email

  def initialize(section_id, pid, name, college, major, level, email)
    @section_id = section_id
    @pid = pid
    @name = name
    @college = college
    @major = major
    @level = level
    @email = email
  end
end

task :load_students_without_section_num => :environment do
  student_list = []
  CSV.foreach(File.expand_path('../students_without_section_num.csv', __FILE__)) do |row|
    pid = row[0]
    name = row[1]
    college = row[2]
    major = row[3]
    level = row[4]
    email = row[5]

    student_list << StudentObj.new(nil, pid, name, college, major, level, email)
  end

  student_list.each do |student|
    stu = Student.find_by(:pid=>student.pid)
    Student.create(:email=>student.email, :name=>student.name, :pid=>student.pid, :password=>student.pid[1..-1], :password_confirmation=>student.pid[1..-1], :college=>student.college, :major=>student.major, :year=>student.level) if stu.nil?
  end
end
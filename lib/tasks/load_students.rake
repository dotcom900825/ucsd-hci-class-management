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


task :load_students => :environment do
  students_list = []
  CSV.foreach(File.expand_path('../student_list.csv', __FILE__)) do |row|
    section_id = row[0]
    pid = row[1]
    name = row[2]
    college = row[4]
    major = row[5]
    level = row[6]
    email = row[7]

    stu = StudentObj.new(section_id, pid, name, college, major, level, email)
    students_list << stu
  end

  students_list.shuffle!

  students_list.each do |student|
    studio = Studio.where(:section_num=>student.section_id).first
    if studio
      studio.students.create(:email=>student.email, :name=>student.name, :pid=>student.pid,
        :password=>student.pid, :password_confirmation=>student.pid, :college=>student.college,
        :major=>student.major, :year=>student.level)
    end
  end
end
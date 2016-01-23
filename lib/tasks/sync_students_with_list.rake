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

task :sync_students_with_list => :environment do
  student_hash = {}
  EXCEPTIONS = ["A00000000", "U07217399", "A11514143"]
  CSV.foreach(File.expand_path('../students_without_section_num.csv', __FILE__)) do |row|
    pid = row[0]
    name = row[1]
    college = row[2]
    major = row[3]
    level = row[4]
    email = row[5]

    student_hash[pid] = StudentObj.new(nil, pid, name, college, major, level, email)
  end

  Student.all.each do |student|
    unless student_hash.has_key?(student.pid)
      next if EXCEPTIONS.include?(student.pid)
      puts "DROPPED: #{student.name}"
      student.destroy
    end
  end

  student_hash.values.each do |student|
    if Student.find_by(:pid=>student.pid).nil?
      puts "ADDED: #{student.name}"
      Student.create(:email=>student.email, :name=>student.name, :pid=>student.pid, :password=>student.pid[1..-1], :password_confirmation=>student.pid[1..-1], :college=>student.college, :major=>student.major, :year=>student.level)
    else
      Student.find_by(:pid=>student.pid).update(:name=>student.name, :college=>student.college, :major=>student.major, :year=>student.level)
    end
  end
end
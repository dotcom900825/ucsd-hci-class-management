class HomeController < ApplicationController
  def index
    
  end

  def studio_stat
    @studios = Studio.all.order("section_num ASC")
  end

  def quiz
    @student_quizzes = StudentQuiz.where(:quiz_id=>params[:id])
  end

  def lab_overview
    if current_user && current_user.is_ta?
      @student_hash = {}
      current_user.studios.each do |studio|
        studio.students.each do |stu|
          @student_hash[stu.name] = stu.labs.size
        end
      end
    else
      flash[:alert] = "not authorized"
      redirect_to root_path
    end

  end

  def ranking
    @students = Student.all.joins(:submissions).where(:submissions=>{:assignment_id=>2})
    
    @final_score = []
    @students.each do |student|
      score_hash = {:pid=>"", :a1=>0, :a2=>0, :a3=>0, :a4=>0, :a5=>0, :a6=>0, :a7=>0, :a8=>0, :a9=>0, :a10=>0, :sa=>0, :lab=>0, :quiz=>0, :extra_credit=>0, :lect_participation=>0, :studio_participation=>0, :total=>0}
      
      [1, 2, 4].each do |aid|
        score_hash["a#{aid}".to_sym] = student.submissions.find_by(:assignment_id=>aid).try(:final_grade).to_i
        unless aid == 1
          score_hash[:sa] += student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i          
        end
      end

      [3, 5, 6, 7, 8, 9, 10].each do |aid|
        if student.submissions.find_by(:assignment_id=>aid).present?
          score_hash["a#{aid}".to_sym] = student.submissions.find_by(:assignment_id=>aid).try(:final_grade).to_i
          score_hash[:sa] += student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i
        else
          if student.team.present?
            student.team.students.each do |group_student|
              if group_student.submissions.find_by(:assignment_id=>aid).present?
                score_hash["a#{aid}".to_sym] = group_student.submissions.find_by(:assignment_id=>aid).try(:final_grade).to_i
                #puts "#{aid} #{group_student.name} #{group_student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i}"
                score_hash[:sa] += group_student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i
              end
            end
          else
            #puts student.id
          end
        end
      end

      if student.submissions.find_by(:assignment_id=>11).present?
          score_hash[:extra_credit] = student.submissions.find_by(:assignment_id=>11).try(:final_grade).to_i
      else
        if student.team.present?
          student.team.students.each do |group_student|
            if group_student.submissions.find_by(:assignment_id=>11).present?
              score_hash[:extra_credit] = group_student.submissions.find_by(:assignment_id=>11).try(:final_grade).to_i
            end
          end
        else
          #puts student.id
        end
      end

      if student.submissions.find_by(:assignment_id=>12).present?
        if student.submissions.find_by(:assignment_id=>12).grading_fields.size > 0
          score_hash[:lect_participation] = student.submissions.find_by(:assignment_id=>12).grading_fields[1].score
          score_hash[:studio_participation] = student.submissions.find_by(:assignment_id=>12).grading_fields[0].score
        end
      end



      score_hash[:lab] = student.student_labs.where(:complete=>true).count
      score_hash[:quiz] = student.student_quizzes.sum(:score)
      score_hash[:pid] = student.pid[4..-1]

      [:a1, :a2, :a3, :a4, :a5, :a6, :a7, :a8, :a9, :a10, :sa, :lab, :quiz, :extra_credit, :lect_participation, :studio_participation].each do |field|
        score_hash[:total] += score_hash[field].to_i
      end

      @final_score << score_hash

    end 

    @final_score.sort_by! {|ele| ele[:total]}
    @final_score.reverse!

  end

  def ranking_with_name
    @students = Student.all.joins(:submissions).where(:submissions=>{:assignment_id=>2})
    
    @final_score = []
    @students.each do |student|
      score_hash = {:name=>"", :pid=>"", :a1=>0, :a2=>0, :a3=>0, :a4=>0, :a5=>0, :a6=>0, :a7=>0, :a8=>0, :a9=>0, :a10=>0, :sa=>0, :lab=>0, :quiz=>0, :extra_credit=>0, :lect_participation=>0, :studio_participation=>0, :total=>0}
      
      [1, 2, 4].each do |aid|
        score_hash["a#{aid}".to_sym] = student.submissions.find_by(:assignment_id=>aid).try(:final_grade).to_i
        unless aid == 1
          score_hash[:sa] += student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i          
        end
      end

      [3, 5, 6, 7, 8, 9, 10].each do |aid|
        if student.submissions.find_by(:assignment_id=>aid).present?
          score_hash["a#{aid}".to_sym] = student.submissions.find_by(:assignment_id=>aid).try(:final_grade).to_i
          score_hash[:sa] += student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i
        else
          if student.team.present?
            student.team.students.each do |group_student|
              if group_student.submissions.find_by(:assignment_id=>aid).present?
                score_hash["a#{aid}".to_sym] = group_student.submissions.find_by(:assignment_id=>aid).try(:final_grade).to_i
                #puts "#{aid} #{group_student.name} #{group_student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i}"
                score_hash[:sa] += group_student.submissions.find_by(:assignment_id=>aid).try(:sa_points).to_i
              end
            end
          else
            #puts student.id
          end
        end
      end

      if student.submissions.find_by(:assignment_id=>11).present?
          score_hash[:extra_credit] = student.submissions.find_by(:assignment_id=>11).try(:final_grade).to_i
      else
        if student.team.present?
          student.team.students.each do |group_student|
            if group_student.submissions.find_by(:assignment_id=>11).present?
              score_hash[:extra_credit] = group_student.submissions.find_by(:assignment_id=>11).try(:final_grade).to_i
            end
          end
        else
          #puts student.id
        end
      end

      if student.submissions.find_by(:assignment_id=>12).present?
        if student.submissions.find_by(:assignment_id=>12).grading_fields.size > 0
          score_hash[:lect_participation] = student.submissions.find_by(:assignment_id=>12).grading_fields[1].score
          score_hash[:studio_participation] = student.submissions.find_by(:assignment_id=>12).grading_fields[0].score
        end
      end



      score_hash[:lab] = student.student_labs.where(:complete=>true).count
      score_hash[:quiz] = student.student_quizzes.sum(:score)
      score_hash[:pid] = student.pid[4..-1]
      score_hash[:name] = student.name

      [:a1, :a2, :a3, :a4, :a5, :a6, :a7, :a8, :a9, :a10, :sa, :lab, :quiz, :extra_credit, :lect_participation, :studio_participation].each do |field|
        score_hash[:total] += score_hash[field].to_i
      end

      @final_score << score_hash

    end 

    @final_score.sort_by! {|ele| ele[:total]}
    @final_score.reverse!
  end

end
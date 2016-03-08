class HomeController < ApplicationController
  def index
    if current_user.present? && !current_user.is_ta?
      @ranking = {}
      @possible_scores = get_possible_points()
      @grades = []
      Student.all.each do |student|
        @ranking[student] = {
          :name => student.name,
          :assignments => [],
          :labs => student.student_labs,
          :quizzes => student.student_quizzes,
          :total => 0
        }
        Assignment.all.order("created_at ASC").each do |assignment|
          submission = Submission.where(student: student, assignment: assignment).order(:updated_at).last
          submission = find_team_submission(assignment, student) if submission.nil?
          @ranking[student][:assignments] << submission
          @ranking[student][:total] += submission.final_grade unless submission.nil?
          @ranking[student][:total] += submission.sa_points unless submission.nil?
          # if submission && submission.grading_fields.size > 0
          #   assignment.rubric_fields.each do |rubric_field|
          #     rubric_field.rubric_field_items.each do |item|
          #       @possible_scores[:assignment] += item.point unless item.extra_credit
          #     end
          #   end
          # end
        end
        @ranking[student][:total] += (@ranking[student][:labs].where(:complete=>true).count * 2)
        @ranking[student][:total] += @ranking[student][:quizzes].sum(:score)
        @grades << @ranking[student][:total]
      end
      @possible_scores[:total] = @possible_scores[:assignment] + @possible_scores[:quiz] + @possible_scores[:lab]
      @grades = @grades.uniq.sort { |x,y| y <=> x }
    end
  end

  def studio_stat
    @studios = Studio.all.order("section_num ASC")
  end

  def quiz
    @student_quizzes = StudentQuiz.where(:quiz_id=>params[:id])
  end

  def staff_progress
    if current_user.present? && current_user.is_ta?
      @average_by_staff = {} # staff to array of hash (graded, submitted, average) 
      @histogram  = {} # student to total score mapping
      Ta.order(:name).each do |ta|
        # next if ta.email == "bsoe@ucsd.edu" || ta.email == "srk@ucsd.edu"
        next if ta.email == "srk@ucsd.edu"
        @average_by_staff[ta] = []
        Assignment.order(:id).each do |assignment|
          submission_info = {
            :assignment=>assignment,
            :submitted=>0,
            :graded=>0,
            :average=>0
          }
          Submission.where(:assignment=>assignment).each do |submission|
            ta.studios.each do |studio|
              if studio.students.include?(submission.student)
                submission_info[:submitted] += 1
                unless submission.grading_fields.empty?
                  submission_info[:graded] += 1
                  submission_info[:average] += submission.final_grade
                end
              end
            end
          end
          submission_info[:average] = submission_info[:submitted] != 0 ? submission_info[:average] / submission_info[:submitted] : 0
          @average_by_staff[ta] << submission_info
        end
      end

      Student.all.each do |student|
        next if student.pid == "A00000000"
        @histogram[student.name] = 0
        @histogram[student.name] += student.submissions.sum(:final_grade)
        @histogram[student.name] += student.submissions.sum(:sa_points)
        @histogram[student.name] += student.student_quizzes.sum(:score)
        @histogram[student.name] += (student.student_labs.where(:complete=>true).count * 2)
      end
      @histogram = @histogram.to_a
      @histogram.insert(0, ["Student Name", "Total Score"])
    else
      flash[:notice] = "Permission denied"
      redirect_to root_url and return
    end
  end

  def lab_overview
    if current_user && current_user.is_ta?
      @student_hash = {}
      current_user.studios.each do |studio|
        studio.students.each do |stu|
          @student_hash[stu.name] = (stu.labs.size * 2)
        end
      end
    else
      flash[:alert] = "Not Authorized"
      redirect_to root_path
    end

  end

  def ranking
    @students = Student.all.joins(:submissions).where(:submissions=>{:assignment_id=>2})
    
    @final_score = []
    @students.each do |student|
      score_hash = {:pid=>"", :total=>0, :a1=>0, :a2=>0, :a3=>0, :a4=>0, :a5=>0, :a6=>0, :a7=>0, :a8=>0, :a9=>0, :a10=>0, :sa=>0, :lab=>0, :quiz=>0, :extra_credit=>0, :lect_participation=>0, :studio_participation=>0}
      
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

      score_hash[:lab] = (student.student_labs.where(:complete=>true).count * 2)
      score_hash[:quiz] = student.student_quizzes.sum(:score)
      score_hash[:quiz] -= student.student_quizzes.minimum(:score) if student.student_quizzes.length > 1
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
      score_hash = {:name=>"", :pid=>"", :total=>0, :a1=>0, :a2=>0, :a3=>0, :a4=>0, :a5=>0, :a6=>0, :a7=>0, :a8=>0, :a9=>0, :a10=>0, :sa=>0, :lab=>0, :quiz=>0, :extra_credit=>0, :lect_participation=>0, :studio_participation=>0}
      
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

      score_hash[:lab] = (student.student_labs.where(:complete=>true).count * 2)
      score_hash[:quiz] = student.student_quizzes.sum(:score)
      score_hash[:quiz] -= student.student_quizzes.minimum(:score) if student.student_quizzes.length > 1
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

  private
  def find_team_submission(assignment, student=current_user)
    return nil unless student.team && assignment.team_based
    Submission.where(student: student.team.students, assignment: assignment).order(:final_grade).last
  end
  def get_possible_points()
    possible_scores = {}
    possible_scores[:assignment] = 165 # hardcoded due to glitch
    possible_scores[:quiz] = Quiz.all.length > 1 ? (Quiz.all.length-1) * 10 : (Quiz.all.length) * 10
    possible_scores[:lab] = (Lab.all.length) * 2
    possible_scores
  end
end
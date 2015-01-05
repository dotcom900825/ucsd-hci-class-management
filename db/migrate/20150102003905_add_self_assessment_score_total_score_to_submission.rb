class AddSelfAssessmentScoreTotalScoreToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :self_assessment_grade, :integer, :default=>0
    add_column :submissions, :ta_grade, :integer, :default=>0
    add_column :submissions, :sa_points, :integer, :default=>0
    add_column :submissions, :final_grade, :integer, :default=>0
  end
end

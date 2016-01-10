class AddGithubLinkToStudentLab < ActiveRecord::Migration
  def change
    add_column :student_labs, :github_link, :text
  end
end

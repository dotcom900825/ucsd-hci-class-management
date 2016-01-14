class AddHerokuLinkToStudentLab < ActiveRecord::Migration
  def change
    add_column :student_labs, :heroku_link, :text
  end
end

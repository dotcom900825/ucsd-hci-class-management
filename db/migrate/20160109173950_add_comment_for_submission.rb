class AddCommentForSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :comment, :text
  end
end

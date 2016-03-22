class RenameColumnToQuestions < ActiveRecord::Migration
  def change
  	rename_column :questions, :creator_question_id, :user_id
  end
end

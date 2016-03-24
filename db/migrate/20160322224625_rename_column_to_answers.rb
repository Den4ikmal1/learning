class RenameColumnToAnswers < ActiveRecord::Migration
  def change
  	rename_column :answers, :creator_answer_id, :user_id
  end
end

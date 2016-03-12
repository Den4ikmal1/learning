class AddColumnIdUsersToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :creator_question_id, :integer
  	add_index  :questions, :creator_question_id
  end
end

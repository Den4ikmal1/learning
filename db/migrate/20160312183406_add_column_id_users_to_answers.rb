class AddColumnIdUsersToAnswers < ActiveRecord::Migration
  def change
  	add_column :answers, :creator_answer_id, :integer
  	add_index  :answers, :creator_answer_id
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :creator_questions, foreign_key: :creator_question_id, class_name: "Question"
  has_many :creator_answers, foreign_key: :creator_answer_id, class_name: "Answer"
end

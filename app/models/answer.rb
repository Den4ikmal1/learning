class Answer < ActiveRecord::Base
	belongs_to :creator_answer
	belongs_to :question
	validates  :body, presence: true
end

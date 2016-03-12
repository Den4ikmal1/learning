class Question < ActiveRecord::Base
	belongs_to :creator_question
	has_many :attachments
	has_many :answers
	validates :title, :body, presence: true
	
end

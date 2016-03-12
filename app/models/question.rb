class Question < ActiveRecord::Base

	belongs_to :creator_question
	has_many :attachments, as: :attachmentable
	has_many :answers

	validates :title, :body, presence: true

	

    accepts_nested_attributes_for :attachments
	
end

class Answer < ActiveRecord::Base

	belongs_to :creator_answer
	belongs_to :question
	validates  :body, presence: true
	has_many :attachments, as: :attachmentable



    accepts_nested_attributes_for :attachments
end

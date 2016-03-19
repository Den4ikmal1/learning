class Answer < ActiveRecord::Base

	belongs_to :creator_answer
	belongs_to :question
	validates  :body, presence: true
	has_many :attachments, as: :attachmentable
	has_many :comments, as: :commentable

	default_scope -> { order "created_at" }

    accepts_nested_attributes_for :attachments
end

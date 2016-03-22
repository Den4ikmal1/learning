class Question < ActiveRecord::Base

	belongs_to :user
	has_many :attachments, as: :attachmentable
	has_many :answers
	has_many :comments, as: :commentable

	validates :title, :body, presence: true

	

    accepts_nested_attributes_for :attachments
	
end

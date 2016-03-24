class Answer < ActiveRecord::Base

	belongs_to :user
	belongs_to :question, touch: true
	validates  :body, presence: true
	has_many :attachments, as: :attachmentable
	has_many :comments, as: :commentable

	after_create :calculate_total

	default_scope -> { order "created_at" }


    accepts_nested_attributes_for :attachments


    private

    def calculate_total
    	Reputation.delay.calculate(self)
    end
end

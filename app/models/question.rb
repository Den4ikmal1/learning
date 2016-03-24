class Question < ActiveRecord::Base

	belongs_to :user
	has_many :attachments, as: :attachmentable
	has_many :answers
	has_many :comments, as: :commentable

	validates :title, :body, presence: true
	
	after_create :update_reputation

	

    accepts_nested_attributes_for :attachments


    private

    def update_reputation
    	self.delay.calculate_reputation
    end

    def calculate_reputation
    	reputation = Reputation.calculate(self)
    	self.user.update(reputation: reputation)
    end
	
end

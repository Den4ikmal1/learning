class AnswersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
    
	def create
		@question = Question.find(params[:question_id])
		@answer = @question.answers.create(answer_params)
    end

    def update
    	@answer = Answer.find(params[:id])
    	@answer.update_attributes(answer_params)
    	@question = @answer.question
    end

	private

	def answer_params
      params.require(:answer).permit(:body)
    end



end

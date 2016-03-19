require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	
	describe 'POST #create' do
	  let(:answer) { create :answer }
	  let(:question) { create :question }
	  
	    it 'load question if parent is question' do
	  	  post :create, comment: attributes_for(:comment), question_id: question, format: :js
	  	  expect(assigns(:parent)).to eq question
	    end	
   
	    it 'load answer if parent is answer' do
	  	  post :create, comment: attributes_for(:comment), answer_id: answer, format: :js
	  	  expect(assigns(:parent)).to eq answer
	    end	
	end
end
require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	 let(:question) { create(:question) }
	describe 'GET #index' do
	  let(:questions) { create_list(:question, 2) }

	  before {	get :index }
	  	it 'renders index view' do
          expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
	  before { get :show, id: question}
	  it 'assigns the requested question to @question' do
	  	expect(assigns(:question)).to eq question
	  end	
	 
	  it 'renders show  view' do
	  	expect(response).to render_template :show
	  end

	  it 'assigns new answer for question' do
	  	expect(assigns(:answer)).to be_a_new(Answer)
	  end
	end

	describe 'GET #new' do
		sign_in_user
		before { get :new }

	    it 'assigns a new Question to @question' do
			expect(assigns(:question)).to be_a_new(Question)
		end
		it 'renders new view' do
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit'
	 sign_in_user
	  before { get :edit, id: question }
	  it 'assigns the requested question to @question' do
	  	expect(assigns(:question)).to eq question
	  end
	   it 'renders edit  view' do
	  	expect(response).to render_template :edit
	  end

	describe 'POST #create' do
		sign_in_user
		context 'with valid attributes' do
		  it 'saves the new question in the database' do
			expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
		  end
		  it 'redirect_to @question view' do
		  	post :create, question: attributes_for(:question)
			expect(response).to redirect_to question_path(assigns(:question))
		  end
		end
		context 'with invalid attributes' do
			it 'does not save the question' do
			  expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
		    end
		    it 're-renders new view' do
		    	post :create, question: attributes_for(:invalid_question)
		    	expect(response).to render_template :new
		    end
		end
	end
	describe 'PATCH #update' do
		sign_in_user
		context 'valid attributes' do
		  it 'assigns the requested question to @question' do
		  	patch :update, id: question, question: attributes_for(:question)
	  	    expect(assigns(:question)).to eq question	
		  end
		  it 'changes question attributes' do 
		  	patch :update, id:question, question: { title: "new title", body: "new body"}
		  	question.reload
		  	expect(question.title).to eq "new title"
		  	expect(question.body).to eq "new body"
		  end
		   it 'redirect_to @question' do
		  	patch :update, id: question, question: attributes_for(:question)
	  	    expect(response).to redirect_to question_path(assigns(:question))
		  end
		end
		context 'invalid attributes' do
		   before { patch :update, id:question, question: { title: "new title", body: nil} }
		  	
		   it 'does not changes question attributes' do 
		  	question.reload
		  	expect(question.title).to eq "MyString"
		  	expect(question.body).to eq "MyText"
		  end
		   it 're renders edit views' do
		     expect(response).to render_template :edit
		  end
		end
	end
	
	describe "DELETE #destroy" do
	  sign_in_user
	  it 'deletes question' do
	  	expect { delete :destroy, id:question}.to change(Question, :count).by(-1)
	  end

	end
end

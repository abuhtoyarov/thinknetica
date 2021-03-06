require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	let(:user) { create(:user) }
	let(:question) {create(:question, user: user)}

	describe 'GET #index' do
		let(:questions) {Question.all}

		before {get :index}
			
		it 'contains all question' do			
			expect(assigns['questions']).to eq(questions)
		end

		it 'render index view' do
			expect(response).to render_template :index
		end
	end


	describe 'GET #show' do

		before {get :show, id: question}

		it 'assigns the requested Question to @question' do			
			expect(assigns(:question)).to eq(question)
		end

		it 'render show view' do
			expect(response).to render_template :show
		end	
	end

	describe 'GET #new' do
		sign_in_user

		before {get :new}

		it 'assigns new Question to @question' do
			expect(assigns(:question)).to be_a_new(Question)
		end

		it 'render new view' do
			expect(response).to render_template(:new)
		end
	end

	describe 'GET edit' do
		sign_in_user
		before {get :edit, id: question}

		it 'assigns the requested Question to @question' do			
			expect(assigns(:question)).to eq(question)
		end

		it 'render edit view' do
			expect(response).to render_template :edit
		end	
	end

	describe 'POST #create' do
		sign_in_user

		context 'with valid attributes' do
			it 'saves the new question to the database' do
				expect { post :create, question: attributes_for(:question)}.to change(Question, :count).by(1)
			end

			it 'redirect to show template' do
				post :create, question: attributes_for(:question)
				expect(response).to redirect_to(question_path(assigns(:question)))
			end

		end

		context 'with invalid attributes' do
			it 'did not save the question' do
				expect { post :create, question: attributes_for(:invalid_question)}.to_not change(Question, :count)
			end

			it 're-render new template' do
				post :create, question: attributes_for(:invalid_question)
				expect(response).to render_template :new
			end

		end
	end

	describe 'PATCH #update' do
		sign_in_user

		context 'with valid attributes' do

			it 'assigns the requested Question to @question' do
				patch :update, id: question, question: attributes_for(:question)			
				expect(assigns(:question)).to eq(question)
			end

			it 'changes question attributes' do
				patch :update, id: question, question: {title: 'New title', body: 'New super body'}			
				question.reload
				expect(question.title).to eq 'New title'
				expect(question.body).to eq 'New super body'
			end

			it 'redirect to the updated question' do
				patch :update, id: question, question: attributes_for(:question)
				expect(response).to redirect_to question
			end
		end

		context 'with invalid attributes' do

			before {patch :update, id: question, question: {title: 'New title', body: nil}}
			it 'does not change question attributes' do
				question.reload
				expect(question.title).to eq 'MyString'
				expect(question.body).to eq 'MyText is very cool'
			end

			it 'render #edit template' do
				expect(response).to render_template :edit
			end
		end
	end

	describe 'DELETE #destroy' do
		sign_in_user

		it 'delete question' do
			question
			expect { delete :destroy, id: question}.to change(Question, :count).by(-1)
		end

		it 'redirect to index view' do
			delete :destroy, id: question
			expect(response).to redirect_to questions_path
		end
	end
end

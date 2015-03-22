require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
	let(:user) { create(:user) }
	let!(:question) {create(:question, user: user)}
	let(:answer) {create(:answer, question: question)}

	

	describe 'POST #create' do
		sign_in_user

		context 'with valid attributes' do
			it 'added the new answer to his question' do
				expect { 
					post :create, 
					answer: attributes_for(:answer), 
					question_id: question, 
					format: :js}.to change(question.answers, :count).by(1)
			end

			it 'render create temlpate' do
				post :create, 
				answer: attributes_for(:answer), 
				question_id: question, 
				format: :js
				expect(response).to render_template :create
			end
		end

		context 'with valid attributes' do
			it 'did not save the answer' do
				expect { 
					post :create, 
					answer: {body: nil}, 
					question_id: question, 
					format: :js}.to_not change(Answer, :count)
			end

			it 'render create temlpate' do
				post :create, 
				answer: {body: nil}, 
				question_id: question, 
				format: :js
				expect(response).to render_template :create
			end
		end
	end

	describe 'PATCH #update' do
		sign_in_user

		context 'with valid attributes' do

			it 'assigns the requested Answer to @answer' do
				patch :update, 
				id: answer, 
				question_id: question,
				answer: attributes_for(:answer), 
				format: :js			
				expect(assigns(:answer)).to eq(answer)
			end

			it 'assigns the requested Question to @question' do
				patch :update, 
				id: answer, 
				question_id: question,
				answer: attributes_for(:answer), 
				format: :js			
				expect(assigns(:question)).to eq(question)
			end

			it 'changes question attributes' do
				patch :update, 
				id: answer,
				question_id: question, 
				answer: {body: 'New answer body'},
				format: :js			
				answer.reload
				expect(answer.body).to eq 'New answer body'
			end

			it 'redirect to the updated question' do
				patch :update, 
				id: answer, 
				question_id: question,
				answer: attributes_for(:answer), 
				format: :js
				expect(response).to render_template :update
			end
		end
	end

	describe 'DELETE #destroy' do
		sign_in_user
		

		it 'delete answer' do
			answer
			expect { 
				delete :destroy, 
				id: answer, 
				question_id: question,
				format: :js }.to change(question.answers, :count).by(-1)
		end

		it 'redirect to index view' do
			delete :destroy, 
			id: answer, 
			question_id: question,
			format: :js
			expect(response).to render_template :create
		end
	end
end

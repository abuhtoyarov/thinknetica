require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
	let(:user) { create(:user) }
	let(:question) {create(:question, user: user)}
	let(:answer) {create(:answer, question: question)}

	

	describe 'POST #create' do
		sign_in_user

		context 'with valid attributes' do
			it 'added the new answer to his question' do
				expect { post :create, answer: attributes_for(:answer), question_id: question}.to change(question.answers, :count).by(1)
			end

			it 'redirect to show template' do
				post :create, answer: attributes_for(:answer), question_id: question
				expect(response).to redirect_to(question_path(assigns(:question)))
			end
		end

		context 'with valid attributes' do
			it 'did not save the answer' do
				expect { post :create, answer: {body: nil}, question_id: question}.to_not change(Answer, :count)
			end

			it 'redirect to show template' do
				post :create, answer: attributes_for(:answer), question_id: question
				expect(response).to redirect_to(question_path(assigns(:question)))
			end
		end
	end

	describe 'DELETE #destroy' do
		sign_in_user
		

		it 'delete answer' do
			answer
			expect { delete :destroy, id: answer, question_id: question}.to change(question.answers, :count).by(-1)
		end

		it 'redirect to index view' do
			delete :destroy, id: answer, question_id: question
			expect(response).to redirect_to question_path(question)
		end
	end
end

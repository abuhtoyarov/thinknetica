require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
	let(:question) {create(:question)}
	let(:answer) {create(:answer)}

	

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
			question
			expect { delete :destroy, id: answer, question_id: question}.to change(Answer, :count).by(-1)
		end

		it 'redirect to index view' do
			delete :destroy, id: answer, question_id: question
			expect(response).to redirect_to questions_path
		end
	end
end

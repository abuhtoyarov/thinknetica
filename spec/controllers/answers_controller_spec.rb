require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
	let(:question) {create(:question)}
	before { @answer = question.answers.build(body: "Lorem ipsum") }
	

	describe 'POST #create' do
		context 'with valid attributes' do
			it 'saves the new answer to the database' do
				expect { post :create, answer: attributes_for(:answer), question_id: question}.to change(Answer, :count).by(1)
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
end

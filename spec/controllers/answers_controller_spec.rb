require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
	describe 'POST #create' do
		let(:question) {create(:question)}
		let(:answer) {create(:answer, question: question)}


		it 'assigns the requested Question to @question' do			
			expect{post :create, answer: {body: 'test', question_id: question.id}}.to change(Answer, :count).by(1)
		end


	end
	
end

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
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
		let(:question) {create(:question)}

		before {get :show, id: question}

		it 'assigns the requested Question to @question' do			
			expect(assigns(:question)).to eq(question)
		end

		it 'render show view' do
			expect(response).to render_template :show
		end	
	end

	describe 'GET #new' do
		before {get :new}

		it 'assigns new Question to @question' do
			expect(assigns(:question)).to be_a_new(Question)
		end

		it 'render new view' do
			expect(response).to render_template(:new)
		end
	end

	describe 'POST #create' do
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
end

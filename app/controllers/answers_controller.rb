class AnswersController < ApplicationController

	before_action :authenticate_user!
	before_action :load_question, only: [:create, :destroy]


	def create
		@answer = @question.answers.new(answer_params)
    @answer.user = current_user
		@answer.save
	end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

	def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    render 'create'
  end

  def best_choice
    @answer = Answer.find(params[:id])
  end

	private

		def load_question
			@question = Question.find(params[:question_id])
		end

		def answer_params
			params.require(:answer).permit(:body)
		end
end

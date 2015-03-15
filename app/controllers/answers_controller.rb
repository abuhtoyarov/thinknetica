class AnswersController < ApplicationController

	before_action :authenticate_user!
	before_action :load_question, only: [:create, :destroy]

	def new
	end

	def create
		@answer = @question.answers.create(answer_params)
		redirect_to question_path(@question)
	end

	def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end

	private

		def load_question
			@question = Question.find(params[:question_id])
		end

		def answer_params
			params.require(:answer).permit(:body)
		end
end

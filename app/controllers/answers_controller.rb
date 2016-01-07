class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_question, only: [:new, :create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    if @answer.save
       # redirect_to @question, notice: 'Your answer successfully create'
    else
      render :create
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy if current_user.author_of?(@answer)
    redirect_to questions_path
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end

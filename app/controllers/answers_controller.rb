class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    if @answer.save
    else
      render :create
    end
  end

  def update
    if current_user.author_of?(@answer)
      if @answer.update(answer_params)
        redirect_to @answer.question, notice: 'Your answer successfully updated'
      else
        render :edit
      end
    else
      redirect_to @answer.question
    end
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end

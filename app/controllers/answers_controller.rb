class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:edit, :update, :destroy]

  authorize_resource

  def edit
    # respond_to do |format|
    #   format.json { render json: @answer}
    #   format.html { redirect_to :edit }
    # end
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question }
        format.js
        format.json do
          response = { answers_count: @question.answers.count, answer: @answer }
          PrivatePub.publish_to "/questions/#{@answer.question_id}/answers",
                                response: response
          render json: response
        end
      else
        format.html { render :create }
        format.js
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.question, notice: 'Your answer successfully updated' }
        format.json { render json: @answer}
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @answer.destroy
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

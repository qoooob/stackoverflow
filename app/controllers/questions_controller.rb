class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    @questions = Question.all
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @question }
    end
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      response = {question: @question}
      PrivatePub.publish_to "/questions", response: response
      redirect_to @question, notice: 'Your question successfully create'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Your question successfully updated' }
        format.json { render json: @question }
      else
        format.html { render :edit }
        format.json { render @question.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
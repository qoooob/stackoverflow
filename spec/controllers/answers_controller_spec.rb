require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:answer) { FactoryGirl.create(:answer) }
  let (:question) { FactoryGirl.create(:question) }

  describe "GET #new" do
    before {get :new, question_id: question }

    it 'assigns new Answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new template' do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context 'valid' do
      it 'saves new answer in DB' do
        expect {
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer)
        }.to change(question.answers, :count).by(1)
      end

      it 'redirect to question_path' do
        post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
      it 'belongs to current question' do
        post :create, question_id: question, answer: FactoryGirl.attributes_for(:answer)
        expect(assigns(:question)).to eq question
      end
    end

    context 'invalid' do
      it 'does not save new answer in DB' do
        expect {
          post :create, question_id: question, answer: FactoryGirl.attributes_for(:invalid_answer)
        }.to_not change(Answer, :count)
      end

      it 'render show template' do
        post :create, question_id: question, answer: FactoryGirl.attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end
end
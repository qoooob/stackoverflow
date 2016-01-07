require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:answer) { create(:answer, question: question) }
  let (:question) { create(:question) }
  let (:user) { create(:user) }

  describe "GET #new" do
    before do
      login(user)
      get :new, question_id: question
    end

    it 'assigns new Answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new template' do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    before { login(user) }
    context 'valid' do
      it 'saves new answer in DB' do
        expect {
          post :create, question_id: question, format: :js, answer: attributes_for(:answer)
        }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, question_id: question, format: :js, answer: attributes_for(:answer)
        expect(response).to render_template :create
      end

      it 'belongs to current question' do
        post :create, question_id: question,format: :js, answer: attributes_for(:answer)
        expect(assigns(:question)).to eq question
      end
    end

    context 'invalid' do
      it 'does not save new answer in DB' do
        expect {
          post :create, question_id: question,format: :js, answer: attributes_for(:invalid_answer)
        }.to_not change(Answer, :count)
      end

      it 'render create template' do
        post :create, question_id: question, format: :js, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :create
      end
    end
  end

  describe "DELETE #destroy" do
    before { login(user) }
    context 'author delete own answer' do
      let!(:answer) { create(:answer, question: question, user: user)}

      it 'deletes answer from DB' do
        expect { delete :destroy, id: answer }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question' do
        delete :destroy, id: answer
        expect(response).to redirect_to questions_path
      end
    end

    context 'non-author can not delete answer' do
      before { answer }

      it 'does not deletes answer from DB' do
        expect { delete :destroy, id: answer }.to_not change(Answer, :count)
      end
    end
  end
end
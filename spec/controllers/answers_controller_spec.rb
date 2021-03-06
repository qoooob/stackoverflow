require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:answer) { create(:answer, question: question) }
  let (:question) { create(:question) }
  let (:user) { create(:user) }

  describe "GET #edit" do
    before do
      login(user)
      get :edit, id: answer
    end

    it 'edit answer' do
      expect(assigns(:answer)).to eq answer
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

  describe "PATCH #update" do
    before { login(user) }
    let!(:answer) { create(:answer, question: question, user: user) }

    context 'valid' do
      before { patch :update, id: answer, answer: { body: 'New Body' } }
      it 'change answer' do
        answer.reload
        expect(answer.body).to eq 'New Body'
      end
      it 'redirect to show' do
        expect(response).to redirect_to question
      end
    end

    context 'invalid' do
      before { patch :update, id: answer, answer: { body: nil } }
      it 'does not change answer' do
        answer.reload
        expect(answer.body).to_not eq nil
      end
      it 'render edit template' do
        expect(response).to render_template :edit
      end
    end

    context 'non-author can not edit answer' do
      before { patch :update, id: answer, answer: { body: 'New Body' } }
      it 'does not edit answer in DB' do
        expect(answer.body).to_not eq 'New Body'
      end
    end
  end

  describe "DELETE #destroy" do
    before { login(user) }
    context 'author delete own answer' do
      let!(:answer) { create(:answer, question: question, user: user)}

      it 'deletes answer from DB' do
        expect { delete :destroy, id: answer, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'render destroy template' do
        delete :destroy, id: answer, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'non-author can not delete answer' do
      before { answer }

      it 'does not deletes answer from DB' do
        expect { delete :destroy, id: answer, format: :js }.to_not change(Answer, :count)
      end
    end
  end
end
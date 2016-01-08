require 'rails_helper'

feature 'Delete Answer' do
  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create_list(:answer, 1, question: question, user: user) }

  scenario 'Author can delete his answer', js: true do
    login(user)
    visit question_path(question)

    click_on "Delete Answer"

    expect(current_path).to eq question_path(question)
    expect(page).to_not have_content answer.first.body
  end

  scenario 'Non-author can not delete answer' do
    login(create(:user))
    visit question_path(question)

    expect(page).to_not have_link 'Delete Answer'
  end

  scenario 'Unauthenticated user can not delete answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete Answer'
  end
end
require 'rails_helper'

feature 'Update the question', %q{
  In order to the question can be edit
  As an authenticated user
  I want to edit question
  } do

  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user) }


  scenario 'Author can edit a question', js: true do
    login(user)
    visit question_path(question)
    click_on "Edit Question"

    expect(page).to have_button 'Save Question'
  end

  scenario 'Non-author can not edit question' do
    login(create(:user))
    visit question_path(question)

    expect(page).to_not have_link 'Edit Question'
  end
  scenario 'Unauthenticated user can not edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit Question'
  end
end
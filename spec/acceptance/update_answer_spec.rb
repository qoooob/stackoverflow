require 'rails_helper'

feature 'Update the answer', %q{
  In order to the answer can be edit
  As an authenticated user
  I want to edit answer
  } do

  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Author can edit answer' do
    login(user)
    visit question_path(question)
    click_on "Edit Answer"

    fill_in 'Body', with: 'text text'

    click_on "Update"

    expect(page).to have_content 'Your answer successfully updated'
    expect(page).to have_content 'text text'
  end

  scenario 'Non-author can not edit answer' do
    login(create(:user))
    visit question_path(question)

    expect(page).to_not have_link 'Edit Answer'
  end
  scenario 'Unauthenticated user can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit Answer'
  end
end
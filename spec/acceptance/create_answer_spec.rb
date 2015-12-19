require 'rails_helper'

feature 'Create answer', %q{
  In order to make answer to community
  As an authenticated user
  I want to be able to answer to question
  } do

  given!(:user) { create(:user) }
  given!(:question) { create(:question)}

  scenario 'Authenticated user create answer' do
    login(user)

    visit question_path(question)
    click_on 'Answer the question'
    fill_in 'Answer', with: 'Answer Body'
    click_on 'Create answer'

    expect(page).to have_content 'Your answer successfully create'
    expect(page).to have_content 'Answer Body'
  end

  scenario 'Non-authenticated user tries to create answer' do
    visit question_path(question)

    click_on 'Answer the question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(current_path).to eq new_user_session_path
  end
end
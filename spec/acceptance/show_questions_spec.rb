require 'rails_helper'

feature 'Show question', %q{
  Any user
  I want to be able to see all questions
  } do

  given!(:user) { create(:user) }

  scenario 'Authenticated user can see all question' do
    login(user)

    visit questions_path

    expect(page).to have_link 'Log out'
    expect(page).to have_content :title
    expect(page).to have_content :body
  end

  scenario 'Non-authenticated user can see all question' do
    visit questions_path

    expect(page).to_not have_link 'Log out'
    expect(page).to have_content :title
    expect(page).to have_content :body
  end
end
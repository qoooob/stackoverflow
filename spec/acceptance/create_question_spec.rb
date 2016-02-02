require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask question
  } do

  given!(:user) { create(:user) }

  background do
    #Capybara.current_driver = :selenium
  end

  scenario 'Authenticated user create question' do
  login(user)

  visit questions_path
  click_on 'Ask question'

  fill_in 'Title', with: 'Test question'
  fill_in 'Text', with: 'text text'
  click_on 'Create question'


  expect(page).to have_content 'Your question successfully create'
  expect(page).to have_content 'Test question'
  expect(page).to have_content 'text text'
  end

  scenario 'Non-authenticated user tries to create question' do
    visit questions_path

    expect(page).to_not have_content 'Ask question'
  end
end
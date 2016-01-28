require 'rails_helper'

feature 'Create answer', %q{
  In order to make answer to community
  As an authenticated user
  I want to be able to answer to question
  } do

  given(:user) { create(:user) }
  given!(:question) { create(:question)}

  background do
    Capybara.current_driver = :selenium
  end

  scenario 'Authenticated user create answer', js: true do
    login(user)

    visit question_path(question)
    fill_in 'Your answer', with: 'Answer Body'
    click_on 'Create answer'

    expect(current_path).to eq question_path(question)
    # within '.answers' do
    #   expect(page).to have_content "Answer Body"
    # end
  end

  scenario 'Non-authenticated user tries to create answer', js: true do
    visit question_path(question)

    expect(page).to_not have_button 'Create answer'
  end

  scenario 'User tries to create invalid answer', js: true do
    login(user)

    visit question_path(question)
    click_on 'Create answer'

    within '.answer-errors' do
      expect(page).to have_content "Body can't be blank"
    end
  end
end
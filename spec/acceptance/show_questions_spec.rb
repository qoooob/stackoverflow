require 'rails_helper'

feature 'Show question', %q{
  Any user
  I want to be able to see all questions
  } do

  given!(:question) { create(:question) }

  scenario 'Any user can see all question' do

    visit questions_path

    expect(page).to have_content :title
    expect(page).to have_content :body
  end

end
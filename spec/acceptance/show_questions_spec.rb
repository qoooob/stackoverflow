require 'rails_helper'

feature 'Show question', %q{
  Any user
  I want to be able to see all questions
  } do

  given!(:questions) { create_list(:question, 3) }

  scenario 'Any user can see all question' do

    visit questions_path
    questions.each do |question|
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(current_path).to eq questions_path
    end
  end
end
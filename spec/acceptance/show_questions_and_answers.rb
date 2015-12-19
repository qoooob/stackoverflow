require 'rails_helper'

feature 'Show questions and answers', %q{
  In order to see questions with answers
  As any user
  I want to see question ans answers
  } do

  given!(:answer) { create(:answer) }

  scenario 'User can read question and answer' do
    visit question_path(answer.question)

    expect(page).to have_content 'Question'
    expect(page).to have_content 'Question body'
    expect(page).to have_content 'Answer Body'
    end
  end

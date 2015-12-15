FactoryGirl.define do
  factory :question do

    title "My question"
    body "Question body"
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end

end

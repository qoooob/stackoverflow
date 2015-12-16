FactoryGirl.define do
  sequence :title do |t|
    "Question_#{t}"
  end
  sequence :body do |b|
    "Question body_#{b}"
  end

  factory :question do
    title
    body
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end

end

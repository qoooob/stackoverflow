FactoryGirl.define do
  sequence :answer_body do |b|
    "Answer Body_#{b}"
  end
  factory :answer do
    question
    body { generate(:answer_body) }
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end

end

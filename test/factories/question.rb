FactoryBot.define do
  factory :question do
    text { "# A Question" }
    user
  end

  factory :full_question, parent: :question do
    transient do
      answer_count { 5 }
      comment_count { 2 }
    end

    after(:create) do |question, evaluator|
      create_list(:full_answer, evaluator.answer_count, question: question)
      create_list(:comment, evaluator.comment_count, post: question)
    end
  end
end

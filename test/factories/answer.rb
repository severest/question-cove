FactoryBot.define do
  factory :answer do
    text { "this is an answer" }
    user
  end

  factory :full_answer, parent: :answer do
    transient do
      comment_count { 2 }
    end

    after(:create) do |answer, evaluator|
      create_list(:comment, evaluator.comment_count, post: answer)
    end
  end
end

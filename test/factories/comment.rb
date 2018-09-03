FactoryBot.define do
  factory :comment do
    text { "hah!" }
    user
  end
end

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    provider { 'test' }
    sequence(:uid) { |n| "test#{n}" }
  end
end

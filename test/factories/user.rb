FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    provider { 'test' }
    sequence(:uid) { |n| "test#{n}" }
    sequence(:name) { |n| "person#{n}" }
  end
end

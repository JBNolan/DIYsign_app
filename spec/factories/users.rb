FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:username) { |n| "username #{n}"}
    zip '03425'
    password 'password'
    password_confirmation 'password'
  end
end

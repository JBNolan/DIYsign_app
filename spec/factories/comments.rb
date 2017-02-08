FactoryGirl.define do
  factory :comment do
    body 'This is the body of the comment'
    user
    project
    vote_tally 0
  end
end

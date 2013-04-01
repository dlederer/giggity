# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    content "MyString"
    score 1
    user_id 1
    reviewer_id 1
  end
end

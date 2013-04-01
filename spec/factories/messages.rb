# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    to_id 1
    from_id 1
    read false
    content "MyString"
    conversation_id 1
  end
end

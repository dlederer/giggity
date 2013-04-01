# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    user_id 1
    embed_code "MyString"
  end
end

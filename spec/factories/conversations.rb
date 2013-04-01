# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation do
    booker_id 1
    performer_id 1
    gig_id 1
    price 1
    approved false
    rider "MyText"
    date "2013-02-19 22:14:09"
    location "MyString"
    booker_confirm false
    performer_confirm false
  end
end

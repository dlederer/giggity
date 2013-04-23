# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :user do
    username Faker::Name.name
    email Faker::Internet.email
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now
    
    factory :booker do
      after(:build)  { |user| user.add_role :booker }
    end
    
    factory :performer do
      after(:build)  { |user| user.add_role :performer }
    end
    
    factory :admin do
      after(:build)  { |user| user.add_role :admin }
    end
  end
end

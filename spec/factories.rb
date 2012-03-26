# This will guess the User class
FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Joe User #{n}"}
    sequence(:username) { |n| "user#{n}"}
    sequence(:email) { |n| "johnhutch+user#{n}@gmail.com"}
    passowrd 'secret'
    
    factory :admin, :class => User do
      sequence(:name) { |n| "Mr. Admin #{n}" }
      sequence(:username) { |n| "admin#{n}"}
      sequence(:email) { |n| "johnhutch+admin#{n}@gmail.com"}
    end
  end


end

# This will guess the User class
FactoryGirl.define do

  factory :role do
    factory :admin_role do
     name 'admin' 
    end

    factory :author_role do 
      name 'author'
    end

    factory :commenter_role do
      name 'commenter'
    end
  end

  factory :user do
    sequence(:name) { |n| "Joe User #{n}"}
    sequence(:email) { |n| "johnhutch+user#{n}@gmail.com"}
    password 'secret'
    
    factory :admin, :class => User do
      sequence(:name) { |n| "Mr. Admin #{n}" }
      sequence(:email) { |n| "johnhutch+admin#{n}@gmail.com"}
      after_create { |user| user.roles << FactoryGirl.create(:admin_role) }
    end
    
    factory :author , :class => User do
      sequence(:name) { |n| "Mr. Author #{n}" }
      sequence(:email) { |n| "johnhutch+author#{n}@gmail.com"}
      after_create { |user| user.roles << FactoryGirl.create(:author_role) }
    end
  end

end

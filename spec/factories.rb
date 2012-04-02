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

  sequence(:name) { |n| "Joe User #{n}"}
  sequence(:email) { |n| "johnhutch+user#{n}@gmail.com"}

  factory :user do
    name
    email
    password 'secret'
    
    factory :admin, :class => User do
      name
      email
      after_create { |user| user.roles << FactoryGirl.create(:admin_role) }
    end
    
    factory :author , :class => User do
      name
      email
      after_create { |user| user.roles << FactoryGirl.create(:author_role) }
    end
  end
  
  sequence(:title) { |n| "Post Title #{n}"}
  sequence(:body) { |n| "The inner post body #{n}"}

  factory :post do
    title
    body
  end

end

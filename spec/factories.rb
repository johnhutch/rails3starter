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

    factory :uploaer_role do
      name 'uploader'
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

    factory :uploader, :class => User do
      name
      email
      after_create { |user| user.roles << FactoryGirl.create(:uploader_role) }
    end
  end
  
  sequence(:title) { |n| "Post Title #{n}"}
  sequence(:body) { |n| "The inner post body #{n}"}

  factory :post do
    title
    body
  end
 
  sequence(:caption) { |n| "This is the photo caption #{n}"}
 
  factory :photo do
    title
    caption
    image { Rack::Test::UploadedFile.new("#{Rails.root}/spec/samples/hutchhead.png", 'image/png', true) }
    
    #broken lazy fixture as of paperclip ver. 3.0.1 -- try again after an update
    #image { paperclip_fixture("photo", "spec/samples/hutchhead.png", "image/png") }
  end
end

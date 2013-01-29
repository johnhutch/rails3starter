require 'spec_helper'

describe "Posts" do
  let(:author) {FactoryGirl.create(:author)}
  let(:author2) {FactoryGirl.create(:author)}
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:uploader) {FactoryGirl.create(:uploader)}
  let(:post) { FactoryGirl.create(:post, user: author) }
  let(:post2) { FactoryGirl.create(:post, user: author) }
  let(:post3) { FactoryGirl.create(:post, user: author) }
  let(:photo) { FactoryGirl.create(:photo, user: uploader) }

  describe "GET /posts" do
    it "displays posts" do
      post
      post2
      post3

      visit posts_path
      page.should have_content(post.title)
      page.should have_content(post2.title)
      page.should have_content(post3.title)
      page.should have_content(post2.body)
    end
  end

  describe "GET /posts/:id" do
    it "displays a single post" do

      visit post_path(post)
      page.should have_content(post.title)
      page.should have_content(post.body)
    end
  end

  describe "POST /posts" do
    it "should allow an author to post a post", :js => true do
      login(author)

      visit new_post_path
      fill_in "Title", :with => "A Sample post title"
      fill_in "Body", :with => "this is what the post says"
      click_link I18n.t('links.add_a_photo')
      fill_in "Photo Title", :with => "A sample photo title"
      fill_in "Photo Caption", :with => "this is the photo caption"
      attach_file("File Upload","#{Rails.root}/spec/samples/hutchhead.png")
      click_button I18n.t('buttons.create_post')
      page.should have_content("A Sample post title")
      page.should have_content("A sample photo title")
      page.should have_content("this is the photo caption")
      page.should have_xpath("//img[contains(@src,\"hutchhead.png\")]") 
    end

    it "should indicate its published date after post is published" do
      login(author)
      post
      post.publish_me

      visit publish_post_path(post)
      page.should have_content("published on")
    end

    it "should default to not being published" do
      login(author)
      post

      visit post_path(post)
      page.should have_content("currently unpublished")
    end
    
    it "should fail validation when the title and body are not filled out" do
      login(author)

      visit new_post_path
      click_button I18n.t('buttons.create_post')
      page.should have_content("Title can't be blank")
      page.should have_content("Body can't be blank")
    end

    it "should not allow a vanilla user to post a post" do
      login(user)
      
      visit new_post_path
      page.should have_content("You are not authorized")
    end
  end

  describe "EDIT /post/:id" do

    it "should allow the author to edit a post" do
      login(author)

      visit edit_post_path(post)
      fill_in "Title", :with => "An edited post title"
      click_button I18n.t('buttons.edit_post')
      page.should have_content( I18n.t('flash.post_updated'))
      page.should have_content('An edited post title')
    end
    
    it "should not allow a vanilla user to edit a post" do
      login(user)
      
      visit edit_post_path(post)
      page.should have_content("You are not authorized")
    end
    
    it "should not allow a different author to edit a post" do
      login(author2)
      
      visit edit_post_path(post)
      page.should have_content("You are not authorized")
    end

    it "should allow an admin to edit another post" do
      login(admin)
      
      visit edit_post_path(post)
      fill_in "Title", :with => "An edited post title"
      click_button I18n.t('buttons.edit_post')
      page.should have_content( I18n.t('flash.post_updated'))
      page.should have_content('An edited post title')
    end
  end
  
  let(:auth_ability) { Ability.new(author) }
  let(:auth2_ability) { Ability.new(author2) }

  describe "destroy abilities" do
    it "should allow the author to destroy post" do
      auth_ability.should be_able_to(:destroy, post)
    end

    it "should now allow another author to destroy post" do
      auth2_ability.should_not be_able_to(:destroy, post)
    end
  end
end

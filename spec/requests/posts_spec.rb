require 'spec_helper'

describe "Posts" do
  let(:author) {FactoryGirl.create(:author)}
  let(:author2) {FactoryGirl.create(:author)}
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:post) { FactoryGirl.create(:post, user: author) }
  let(:post2) { FactoryGirl.create(:post, user: author) }
  let(:post3) { FactoryGirl.create(:post, user: author) }

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
    it "should allow an author to post a post" do
      login(author)

      visit new_post_path
      fill_in "Title", :with => "A Sample post title"
      fill_in "Body", :with => "this is what the post says"
      click_button I18n.t('buttons.create_post')
      page.should have_content("A Sample post title")
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

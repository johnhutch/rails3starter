require 'spec_helper'

def login(user)
  visit new_user_session_path
  fill_in "Email", :with => user.email
  fill_in "Password", :with => user.password
  click_button "Sign in"
  page.should have_content("Signed in successfully")
end

describe "Posts" do
  describe "GET /posts" do
    it "displays posts" do
      Post.create!(:title => "A Sample post title", :body => "This is what the post says")
      visit posts_path
      page.should have_content("A Sample post title")
    end
  end

  describe "POST /posts" do
    it "should log in and post a post" do
      author = FactoryGirl.create(:author)
      login(author)

      visit new_post_path
      fill_in "Title", :with => "A Sample post title"
      fill_in "Body", :with => "this is what the post says"
      click_button "Create Post"
      page.should have_content("A Sample post title")
    end
  end
end

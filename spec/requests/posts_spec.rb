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
      Post.create!(:title => "Another post title", :body => "This is what the second post says")
      Post.create!(:title => "A third post title", :body => "This is what the third post says")
      visit posts_path
      page.should have_content("A Sample post title")
      page.should have_content("Another post title")
      page.should have_content("A third post title")
      page.should have_content("This is what the third post says")
    end
  end

  describe "GET /posts/:id" do
    it "displays a single post" do
      author = FactoryGirl.create(:author)
      post = Post.create!(:title => "A single post title", :body => "This is what the post says", :user => author)

      visit post_path(post)
      page.should have_content("A single post title")
      page.should have_content("This is what the post says")
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

require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "displays posts" do
      Post.create!(:title => "A Sample post title", :body => "This is what the post says")
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_path
      response.body.should include("A Sample post title");
    end
  end

  describe "POST /posts" do
    it "should post a posts" do
      post_via_redirect posts_path, :post => {:title => "A Sample post title", :body => "This is what the post says"}
      response.body.should include("A Sample post title");
    end
  end
end

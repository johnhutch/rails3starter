require 'spec_helper'

describe "Comments" do
  let(:user) {FactoryGirl.create(:nobody)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:commenter) {FactoryGirl.create(:commenter)}
  let(:author_commenter) {FactoryGirl.create(:author_commenter)}

  let(:post) { FactoryGirl.create(:post, user: author_commenter) }
  let(:comment1) { FactoryGirl.create(:comment, user: author_commenter, parent: post) }
  let(:comment2) { FactoryGirl.create(:comment, user: commenter, parent: post) }
  let(:comment3) { FactoryGirl.create(:comment, user: commenter, parent: post) }

  describe "GET /posts/:id" do
    it "displays a post with comments" do
      comment1
      comment2
      comment3

      visit post_path(post)
      expect(page).to have_content(comment1.body)
      expect(page).to have_content(comment2.body)
      expect(page).to have_content(comment3.body)
    end
  end

  describe "POST /post/:id/comment" do
    it "should allow a commenter to post a comment" do
      login(author_commenter)
      visit post_path(post)

      fill_in "comment_body", :with => "A sample comment body."
      click_button I18n.t('buttons.create_comment')
      expect(page).to have_content("A sample comment body")
    end
    
    it "should fail validation when the body is not filled out" do
      login(author_commenter)
      visit post_path(post)

      click_button I18n.t('buttons.create_comment')

      expect(page).to have_content(I18n.t('flash.comment_problem'))
    end

    it "should not allow a vanilla user to post a comment" do
      login(user)
      visit post_path(post)
      
      expect(page).not_to have_content(I18n.t('labels.post_a_comment'))
    end
  end

  describe "EDIT /post/:id/comment" do

    it "should allow the comment author to edit their comment" do
      login(author_commenter)
      comment1
      visit post_path(post)
  
      click_link('edit_comment_' + comment1.id.to_s)

      expect(page).not_to have_content("You are not authorized")
      fill_in "comment_body", :with => "An edited comment body."
      click_button I18n.t('buttons.edit_comment')
      expect(page).to have_content( I18n.t('flash.comment_updated'))
      expect(page).to have_content('An edited comment body.')
    end
    
    it "should not allow a vanilla user to edit a post" do
      login(user)
      comment1
      
      visit edit_comment_path(comment1)
      expect(page).to have_content("You are not authorized")
    end
    
    it "should not allow a different author to edit a post" do
      login(commenter)
      
      visit edit_comment_path(comment1)
      expect(page).to have_content("You are not authorized")
    end

    it "should allow an admin to edit another post" do
      login(admin)
      
      visit edit_comment_path(comment1)
      expect(page).not_to have_content("You are not authorized")
      fill_in "comment_body", :with => "An edited comment body."
      click_button I18n.t('buttons.edit_comment')
      expect(page).to have_content( I18n.t('flash.comment_updated'))
      expect(page).to have_content('An edited comment body')
    end
  end
  
  let(:auth_ability) { Ability.new(author_commenter) }
  let(:auth2_ability) { Ability.new(commenter) }

  describe "destroy abilities" do
    it "should allow the author to destroy post" do
      expect(auth_ability).to be_able_to(:destroy, comment1)
    end

    it "should not allow another author to destroy post" do
      expect(auth2_ability).not_to be_able_to(:destroy, comment1)
    end
  end
end


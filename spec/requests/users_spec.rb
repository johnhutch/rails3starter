require 'spec_helper'

describe "Users" do
  
  describe "GET /users/sign_in" do
    it "displays the login form" do
      visit new_user_session_path
      page.should have_content("Sign in");
    end
  end

  describe "POST /users/sign_in" do
    it "logs the user in" do 
      user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
      page.should have_content( I18n.t('devise.sessions.signed_in') )
    end
  end

  describe "GET /users/sign_up" do
    it "displays the signup form" do
      visit new_user_registration_path
      page.should have_content("Sign up")
    end
  end

  describe "POST /users/" do 
    it "signs a user up" do
      visit new_user_registration_path
      page.should have_content("Sign up")
      fill_in "Email", :with => "test@email.com"
      fill_in "Password", :with => "secret"
      fill_in "Confirm Password", :with => "secret"
      fill_in "Name", :with => "New user!"
      click_button "Sign up"
      page.should have_content("Signed in as")
      page.should have_content( I18n.t('devise.registrations.signed_up') )
    end
  end
end
